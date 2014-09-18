
CREATE PROCEDURE [dbo].[sp_RecordRawText_Save]
	@number int
	,@rawNumber int = null
	,@choiceNumber int = null
	,@text nvarchar(MAX) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[RecordRawText] where [Number] = @number ))
	begin
		
		Update [dbo].[RecordRawText] set 
			[RawNumber] = isNull(@rawNumber, [RawNumber]), 
			[ChoiceNumber] = isNull(@choiceNumber, [ChoiceNumber]), 
			[Text] = isNull(@text, [Text])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[RecordRawText] (
			[Number], 
			[RawNumber], 
			[ChoiceNumber], 
			[Text]
		) values (
			 @number, 
			 @rawNumber, 
			 @choiceNumber, 
			 @text
		)

	end
END

