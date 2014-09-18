
CREATE PROCEDURE [dbo].[sp_Record_GetList]
	@surveyNumber int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * --,[TargetNumber], [TargetMark], [MatchKey], [MatchFilter]
	FROM [dbo].[Record]
	where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
END
