-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GenericTree_GetDepartmentTreeByPublish]
	-- Add the parameters for the stored procedure here
	@publishNumber int = 0
	,@publishGuid uniqueidentifier 
	,@uiculture varchar(10) = null
	,@memberId varchar(20) = null
	,@showAll bit = 1 -- @showAll 指的是要不要顯示未設定的項目，無論設定為何都只會列出有權限的。
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	if (@publishNumber = 0 and @publishGuid <> dbo.fn_EmptyGuid())
	begin
		select @publishNumber = Number from PublishSetting where [Guid] = @publishGuid
	end

	begin

		select Convert(bit,isNull(pd.PublishNumber,0)) as Checked
		, dt.* 
		, pd.Seme
		, (select [Text] from dbo.fn_GetiCanSeme(d.SchoolId,d.Id,'', Convert(varchar, pd.Seme))) as SemeText
		from fnDepartmentTree(@memberId) dt
		left outer join PublishDepartment pd on pd.DepartmentId = dt.Id and pd.PublishNumber = @publishNumber
		inner join v_Department d on d.Id = dt.Id
		where isNull(pd.PublishNumber,0) >= (1-@showAll) and HasRole = 1
		order by dt.[Path]
	end


END
/*
declare @publishNumber int = 110
	,@publishGuid uniqueidentifier 
	,@memberId varchar(20) = 'atchao'
	,@showAll bit = 1
exec sp_GenericTree_GetDepartmentTreeByPublish @publishNumber,null,@memberId,@showAll

	if (@publishNumber = 0 and @publishGuid <> dbo.fn_EmptyGuid())
	begin
		select @publishNumber = Number from PublishSetting where [Guid] = @publishGuid
	end

	begin

		select Convert(bit,isNull(pd.PublishNumber,0)) as Checked, dt.* 
		from fnDepartmentTree(@memberId) dt
		left outer join PublishDepartment pd on pd.DepartmentId = dt.Id and pd.PublishNumber = @publishNumber
		where isNull(pd.PublishNumber,0) >= (1-@showAll) and HasRole = 1
		order by dt.[Path]
	end

*/