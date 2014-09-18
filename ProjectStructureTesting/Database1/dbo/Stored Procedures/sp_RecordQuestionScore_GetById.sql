
CREATE PROCEDURE [dbo].[sp_RecordQuestionScore_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [IndexNumber], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber], [Score]
	FROM [dbo].[RecordQuestionScore]
	where [Number] = @number
END

