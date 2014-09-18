
CREATE PROCEDURE [dbo].[sp_ChoiceScore_Save]
	@number int
	,@configNumber int = null
	,@choiceNumber int = null
	,@score decimal = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[ChoiceScore] where [Number] = @number ))
	begin
		
		Update [dbo].[ChoiceScore] set 
			[ConfigNumber] = isNull(@configNumber, [ConfigNumber]), 
			[ChoiceNumber] = isNull(@choiceNumber, [ChoiceNumber]), 
			[Score] = isNull(@score, [Score])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[ChoiceScore] (
			[ConfigNumber], 
			[ChoiceNumber], 
			[Score]
		) values (
			 @configNumber, 
			 @choiceNumber, 
			 @score
		)

	end
END

