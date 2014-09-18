
CREATE PROCEDURE [dbo].[sp_RecordRaw_Save]
	@number int = 0
	,@recordNumber int = null
	,@questionNumber int = null
	,@subsetNumber int = null
	,@groupingNumber int = null
	,@answerText nvarchar(max) = null
	,@answerValue tinyint = null
	,@chooseCount tinyint = 0
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[RecordRaw] where [Number] = @number ))
	begin
		
		Update [dbo].[RecordRaw] set 
			[RecordNumber] = isNull(@recordNumber, [RecordNumber]), 
			[QuestionNumber] = isNull(@questionNumber, [QuestionNumber]), 
			[SubsetNumber] = isNull(@subsetNumber, [SubsetNumber]), 
			[GroupingNumber] = isNull(@groupingNumber, [GroupingNumber]),
			[AnswerText] = @answerText,
			[AnswerValue] = @answerValue,
			[ChooseCount] = @chooseCount
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[RecordRaw] (
			[RecordNumber], 
			[QuestionNumber], 
			[SubsetNumber], 
			[GroupingNumber],
			[AnswerText],
			[AnswerValue],
			[ChooseCount]
		) values (
			 @recordNumber, 
			 @questionNumber, 
			 @subsetNumber, 
			 @groupingNumber,
			 @answerText,
			 @answerValue,
			 @chooseCount
		)

	end
END

