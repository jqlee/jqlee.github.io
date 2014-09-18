
CREATE PROCEDURE [dbo].[sp_RecordRaw_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber], [AnswerText], [AnswerValue], [ChooseCount]
	FROM [dbo].[RecordRaw]
	where [Number] = @number
END

