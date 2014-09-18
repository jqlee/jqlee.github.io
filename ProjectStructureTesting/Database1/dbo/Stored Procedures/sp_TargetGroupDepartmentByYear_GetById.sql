
CREATE PROCEDURE [dbo].[sp_TargetGroupDepartmentByYear_GetById]
	@surveyNumber int = null
	,@groupYear int = null
	,@departmentId varchar(8) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [SurveyNumber], [GroupYear], [DepartmentId], [Name]
	FROM [dbo].[TargetGroupDepartmentByYear]
	where [SurveyNumber] = @surveyNumber
	 and [GroupYear] = @groupYear
	 and [DepartmentId] = @departmentId
END


