
CREATE PROCEDURE [dbo].[sp_TargetDepartment_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [SurveyNumber], [DepartmentId], [Level], [Name]
	FROM [dbo].[TargetDepartment]
	where [Number] = @number
END


