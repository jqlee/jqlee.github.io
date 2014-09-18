-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GenericTree_GetDepartmentListByPublish]
	-- Add the parameters for the stored procedure here
	@publishNumber int = 0
	,@publishGuid uniqueidentifier 
	,@uiculture varchar(10) = null
	,@memberId varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	if (@publishNumber = 0 and @publishGuid <> dbo.fn_EmptyGuid())
	begin
		select dt.*, pd.Seme 
		, (select [Text] from dbo.fn_GetiCanSeme(d.SchoolId,d.Id,@uiculture, Convert(varchar, pd.Seme))) as SemeText
		from PublishSetting ps
		inner join PublishDepartment pd on pd.PublishNumber = ps.Number
		inner join fnDepartmentTree(@memberId) dt on dt.Id = pd.DepartmentId
		inner join v_Department d on d.Id = pd.DepartmentId
		where ps.[Guid] = @publishGuid
	end
	else
	begin
		select dt.*, pd.Seme 
		, (select [Text] from dbo.fn_GetiCanSeme(d.SchoolId,d.Id,@uiculture, Convert(varchar, pd.Seme))) as SemeText
		from PublishDepartment pd 
		inner join fnDepartmentTree(@memberId) dt on dt.Id = pd.DepartmentId
		inner join v_Department d on d.Id = pd.DepartmentId
		where pd.PublishNumber = @publishNumber
	end


 /*
	select dt.*, pd.Seme 
	from PublishDepartment pd 
	inner join fnDepartmentTree(@memberId) dt on dt.Id = pd.DepartmentId
	where pd.PublishNumber = @publishNumber
*/
END
/*
declare @publishNumber int = 110
	,@publishGuid uniqueidentifier 
	,@memberId varchar(20) = 'atchao'
exec sp_GenericTree_GetDepartmentListByPublish @publishNumber,@publishGuid,@memberId

select * from PublishDepartment where PublishNumber = 110
*/