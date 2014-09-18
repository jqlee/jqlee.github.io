
CREATE PROCEDURE [dbo].[sp_TargetGroupDepartmentByYear_Delete]
	@surveyNumber int
	,@groupYear int
	,@departmentId varchar(8)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetGroupDepartmentByYear] where [SurveyNumber] = @surveyNumber
	 and [GroupYear] = @groupYear
	 and [DepartmentId] = @departmentId
END
