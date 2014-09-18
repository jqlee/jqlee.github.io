
CREATE PROCEDURE [dbo].[sp_RecordQuestionScore_Save]
	@number int
	,@indexNumber int = null
	,@recordNumber int = null
	,@questionNumber int = null
	,@subsetNumber int = null
	,@groupingNumber int = null
	,@score float = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[RecordQuestionScore] where [Number] = @number ))
	begin
		
		Update [dbo].[RecordQuestionScore] set 
			[IndexNumber] = isNull(@indexNumber, [IndexNumber]), 
			[RecordNumber] = isNull(@recordNumber, [RecordNumber]), 
			[QuestionNumber] = isNull(@questionNumber, [QuestionNumber]), 
			[SubsetNumber] = isNull(@subsetNumber, [SubsetNumber]), 
			[GroupingNumber] = isNull(@groupingNumber, [GroupingNumber]), 
			[Score] = isNull(@score, [Score])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[RecordQuestionScore] (
			[IndexNumber], 
			[RecordNumber], 
			[QuestionNumber], 
			[SubsetNumber], 
			[GroupingNumber], 
			[Score]
		) values (
			 @indexNumber, 
			 @recordNumber, 
			 @questionNumber, 
			 @subsetNumber, 
			 @groupingNumber, 
			 @score
		)

	end
END

