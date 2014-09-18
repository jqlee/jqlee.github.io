
CREATE PROCEDURE [dbo].[sp_QuestionUnit_GetById]
	@surveyNumber int = 0
	,@questionNumber int = 0
	,@subsetNumber int = 0
	,@qroupingNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [SurveyNumber],[AutoId], [Section], [QuestionNumber], [Title], [Description], [SubsetNumber], [SubsetText], [GroupingNumber], [GroupingText], [QuestionSort], [SubsetSort], [GroupingSort], [SortOrder]
	FROM [dbo].[v_QuestionUnit]
	where [SurveyNumber] = @surveyNumber and [QuestionNumber] = @questionNumber and [SubsetNumber] = @subsetNumber and [GroupingNumber] = @qroupingNumber
END

