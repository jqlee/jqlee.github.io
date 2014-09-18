
CREATE PROCEDURE [dbo].[sp_RecordQuestionScore_GetList]
	@indexNumber int = 0
	,@recordNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	if (@indexNumber = 0) set @indexNumber = null;
	if (@recordNumber = 0) set @recordNumber = null;
	SELECT [Number], [IndexNumber], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber], [Score]
	FROM [dbo].[RecordQuestionScore]
	where [IndexNumber] = isNull(@indexNumber,[IndexNumber])
	 and [RecordNumber] = isNull(@recordNumber,[RecordNumber])

END
