
CREATE PROCEDURE [dbo].[sp_RecordRawValue_Save]
	@number int
	,@rawNumber int = null
	,@choiceNumber int = null
	--,@answerText nvarchar(max) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[RecordRawValue] where [Number] = @number ))
	begin
		
		Update [dbo].[RecordRawValue] set 
			[RawNumber] = isNull(@rawNumber, [RawNumber]), 
			[ChoiceNumber] = isNull(@choiceNumber, [ChoiceNumber])
			--,[AnswerText] = @answerText
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[RecordRawValue] (
			[Number], 
			[RawNumber], 
			[ChoiceNumber]
			--, [AnswerText]
		) values (
			 @number, 
			 @rawNumber, 
			 @choiceNumber
			 --, @answerText
		)

	end
END

