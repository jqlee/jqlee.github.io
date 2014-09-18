
CREATE PROCEDURE [dbo].[sp_QuesItem_Save]
	@number int
	,@questionNumber int = null
	,@text nvarchar(MAX) = null
	,@creator varchar(20) = null
	,@creatorName nvarchar(50) = null
	,@isVisible bit = null
	,@score int = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[QuesItem] where [Number] = @number ))
	begin
		
		Update [dbo].[QuesItem] set 
			[QuestionNumber] = isNull(@questionNumber, [QuestionNumber]), 
			[Text] = isNull(@text, [Text]), 
			[Creator] = isNull(@creator, [Creator]), 
			[CreatorName] = isNull(@creatorName, [CreatorName]), 
			[IsVisible] = isNull(@isVisible, [IsVisible]), 
			[Score] = isNull(@score, [Score])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[QuesItem] (
			[QuestionNumber], 
			[Text], 
			[Creator], 
			[CreatorName], 
			[IsVisible], 
			[Score]
		) values (
			 @questionNumber, 
			 @text, 
			 @creator, 
			 @creatorName, 
			 @isVisible, 
			 @score
		)

	end
END


