
CREATE PROCEDURE [dbo].[sp_TargetGroupDepartmentByYear_GetList]
	
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [SurveyNumber], [GroupYear], [DepartmentId], [Name]
	FROM [dbo].[TargetGroupDepartmentByYear]
	 
END

