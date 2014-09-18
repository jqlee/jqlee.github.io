
Create PROCEDURE [dbo].[sp_RecordRawText_SaveByKeys]
	@recordNumber int = 0
	,@questionNumber int = 0
	,@subsetNumber int = 0
	,@groupingNumber int = 0
	,@text nvarchar(max) = null
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
		Insert into [dbo].[RecordRawText] (
			[RawNumber], 
			[Text]
		) values (
			 @rawNumber, 
			 @text
		)

	end
END

