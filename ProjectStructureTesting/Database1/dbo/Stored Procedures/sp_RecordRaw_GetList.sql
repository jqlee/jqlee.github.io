
CREATE PROCEDURE [dbo].[sp_RecordRaw_GetList]
	@recordNumber int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber], [AnswerText], [AnswerValue], [ChooseCount]
	FROM [dbo].[RecordRaw]
	where [RecordNumber] = isNull(@recordNumber,[RecordNumber])
END
