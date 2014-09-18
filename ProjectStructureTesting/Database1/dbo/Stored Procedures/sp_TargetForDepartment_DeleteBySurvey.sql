
Create PROCEDURE [dbo].[sp_TargetForDepartment_DeleteBySurvey]
	@surveyNumber int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetForDepartment] where [SurveyNumber] = @surveyNumber
END