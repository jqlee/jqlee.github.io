
CREATE PROCEDURE [dbo].[sp_Subset_Create]
	@dimension int = 0
	,@questionId uniqueidentifier = null
	,@text nvarchar(200) = null
	,@sortOrder tinyint = 0
AS
BEGIN
	SET NOCOUNT ON;

	if (@sortOrder = 0)
		select @sortOrder = max(s.[SortOrder])
		from question q inner join Subset s on s.QuestionNumber = q.Number
		where q.[Guid] = @questionId

	if (@sortOrder > 254) 
		set @sortOrder = 255;
	else if @sortOrder is null
		set @sortOrder = 1
	else
		set @sortOrder = @sortOrder + 1;

	Insert into [dbo].[Subset] (
			[Dimension], 
			[QuestionNumber], 
			[Text], 
			[SortOrder])
	Select 
			 @dimension as [Dimension], 
			 Question.Number as [QuestionNumber], 
			 @text as [Text], 
			 @sortOrder as [SortOrder]
	from [Question] where [Guid] = @questionId

END

