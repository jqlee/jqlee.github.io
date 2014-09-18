
Create PROCEDURE [dbo].[sp_TargetForGroup_Clear]
	@surveyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetForGroup] where [SurveyNumber] = @surveyNumber
END