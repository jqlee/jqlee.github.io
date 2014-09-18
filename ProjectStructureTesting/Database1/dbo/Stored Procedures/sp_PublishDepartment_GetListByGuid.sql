-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PublishDepartment_GetListByGuid]
	-- Add the parameters for the stored procedure here
	@publishGuid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT pd.* , d.Name as DepartmentName
	, (select [Text] from dbo.fn_GetiCanSeme(pd.DepartmentId,'', Convert(varchar, pd.Seme))) as SemeText
	from PublishSetting ps
	inner join PublishDepartment pd on pd.PublishNumber = ps.Number
	inner join v_Department d on d.Id = pd.DepartmentId
	where ps.[Guid] = @publishGuid
	order by d.Id,d.name
END

/*

select [Guid],* from PublishSetting where Number in (110,112,106,103,102,101)

declare @guid uniqueidentifier = 'B2F28BB8-4C97-4D15-A55F-E67210C4FA8B'
	SELECT pd.* , d.Name as DepartmentName
	, (select [Text] from dbo.fn_GetiCanSeme(d.SchoolId,d.Id,'', Convert(varchar, pd.Seme))) as SemeText
	from PublishSetting ps
	inner join PublishDepartment pd on pd.PublishNumber = ps.Number
	inner join v_Department d on d.Id = pd.DepartmentId
	where ps.[Guid] = @guid
	order by d.Id,d.name

select * from fn_GetiCanSemeList('1000','CBNTR','')

select * from v_Department
*/