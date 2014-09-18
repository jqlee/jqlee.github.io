
CREATE PROCEDURE [dbo].[sp_ChoiceScore_GetNewList]
	@questionNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	Select @questionNumber as QuestionNumber, 0 as Number, 0 as [ConfigNumber], Number as ChoiceNumber, [Text] as [ChoiceText], 0.0 as [Score]
	from [Choice] 
	where QuestionNumber = @questionNumber
	order by [SortOrder]

END

