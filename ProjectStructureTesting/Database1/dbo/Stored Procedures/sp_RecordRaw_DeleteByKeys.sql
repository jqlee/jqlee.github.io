
CREATE PROCEDURE [dbo].[sp_RecordRaw_DeleteByKeys]
	@recordNumber int = 0
	,@questionNumber int = 0
	,@subsetNumber int = 0
	,@groupingNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	declare @rawNumber int;

	select @rawNumber = [Number] from [RecordRaw]
	where [RecordNumber] = @recordNumber
	 and [QuestionNumber] = @questionNumber
	 and [SubsetNumber] = @subsetNumber
	 and [GroupingNumber] = @groupingNumber
	
	if (@rawNumber is not null and @rawNumber > 0)
	begin
		begin tran T1;
		Delete FROM [dbo].[RecordRaw] where [Number] = @rawNumber
		Delete FROM [dbo].[RecordRawValue] where [RawNumber] = @rawNumber
		Delete FROM [dbo].[RecordRawText] where [RawNumber] = @rawNumber
		commit tran T1;
	end

END