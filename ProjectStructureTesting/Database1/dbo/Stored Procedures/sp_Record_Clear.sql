
Create PROCEDURE [dbo].[sp_Record_Clear]
	@number int
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRAN T1;

	Delete FROM [dbo].[RecordRawText]
	from [dbo].[RecordRawText] t
	inner join [dbo].[RecordRaw] w on t.[RawNumber] = w.[Number]
	where w.[RecordNumber] = @number

	Delete FROM [dbo].[RecordRawValue]
	from [dbo].[RecordRawValue] v
	inner join [dbo].[RecordRaw] w on v.[RawNumber] = w.[Number]
	where w.[RecordNumber] = @number

	Delete FROM [dbo].[RecordRaw] where [RecordNumber] = @number

	Delete FROM [dbo].[Record] where [Number] = @number

	COMMIT TRAN T1;

END