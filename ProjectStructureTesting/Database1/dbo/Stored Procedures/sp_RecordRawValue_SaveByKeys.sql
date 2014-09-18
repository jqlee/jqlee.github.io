
CREATE PROCEDURE [dbo].[sp_RecordRawValue_SaveByKeys]
	@recordNumber int = 0
	,@questionNumber int = 0
	,@subsetNumber int = 0
	,@groupingNumber int = 0
	,@choiceNumber int = 0
	--,@answerText nvarchar(max) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	--insert mode only
	declare @rawNumber int;

	select @rawNumber = [Number] from [RecordRaw]
	where [RecordNumber] = @recordNumber
	 and [QuestionNumber] = @questionNumber
	 and [SubsetNumber] = @subsetNumber
	 and [GroupingNumber] = @groupingNumber

	if (@rawNumber is not null)
	begin
		Insert into [dbo].[RecordRawValue] (
			[RawNumber], 
			[ChoiceNumber]
			--,[AnswerText]
		) values (
			 @rawNumber, 
			 @choiceNumber
			 --,@answerText
		)

	end
END

