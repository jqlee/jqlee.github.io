
CREATE PROCEDURE [dbo].[sp_Choice_Save]
	@number int
	,@questionNumber int = null
	,@text nvarchar(200) = null
	,@sortOrder tinyint = 0
	,@acceptText bit = 0
	,@isJoined bit = 0
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	--如果sortOrder為0，自動放到最後
	if (@sortOrder = 0)
		select @sortOrder = max(SortOrder)+1 from [Choice] where [QuestionNumber] = @questionNumber;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Choice] where [Number] = @number ))
	begin
		
		Update [dbo].[Choice] set 
			[QuestionNumber] = isNull(@questionNumber, [QuestionNumber]), 
			[Text] = isNull(@text, [Text]), 
			[SortOrder] = isNull(@sortOrder, [SortOrder]), 
			[AcceptText] = isNull(@acceptText, [AcceptText]),
			[IsJoined] = isNull(@isJoined, [IsJoined])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[Choice] (
			
			[QuestionNumber], 
			[Text], 
			[SortOrder], 
			[AcceptText],
			[IsJoined]
		) values (
			
			 @questionNumber, 
			 @text, 
			 @sortOrder, 
			 @acceptText,
			 @isJoined
		)

		select SCOPE_IDENTITY();--回傳剛新增的自動編號

	end
END

