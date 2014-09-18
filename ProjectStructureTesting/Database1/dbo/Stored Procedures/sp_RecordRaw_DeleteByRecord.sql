
CREATE PROCEDURE [dbo].[sp_RecordRaw_DeleteByRecord]
	@recordNumber int
AS
BEGIN
	SET NOCOUNT ON;
	begin tran T1;
	 
	Delete FROM [dbo].[RecordRawValue] 
	from [dbo].[RecordRaw] r
	inner join [RecordRawValue] rv on rv.RawNumber = r.Number
	where r.[RecordNumber] = @recordNumber

	Delete FROM [dbo].[RecordRawText] 
	from [dbo].[RecordRaw] r
	inner join [RecordRawText] rv on rv.RawNumber = r.Number
	where r.[RecordNumber] = @recordNumber

	Delete FROM [dbo].[RecordRaw] where [RecordNumber] = @recordNumber

	commit tran T1;

END