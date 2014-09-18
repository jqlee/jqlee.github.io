
CREATE PROCEDURE [dbo].[sp_Subset_Save]
	@number int
	,@dimension int = null
	,@questionNumber int = null
	,@text nvarchar(200) = null
	,@sortOrder tinyint = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Subset] where [Number] = @number ))
	begin
		
		Update [dbo].[Subset] set 
			[Dimension] = isNull(@dimension, [Dimension]), 
			[QuestionNumber] = isNull(@questionNumber, [QuestionNumber]), 
			[Text] = isNull(@text, [Text]), 
			[SortOrder] = isNull(@sortOrder, [SortOrder])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[Subset] (
			[Dimension], 
			[QuestionNumber], 
			[Text], 
			[SortOrder]
		) values (
			 @dimension, 
			 @questionNumber, 
			 @text, 
			 @sortOrder
		)

	end
END

