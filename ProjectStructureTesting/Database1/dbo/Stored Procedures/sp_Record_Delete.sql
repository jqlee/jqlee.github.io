
CREATE PROCEDURE [dbo].[sp_Record_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;

	begin tran t1

	delete from RecordRawValue where RawNumber in (
		Select Number from RecordRaw where RecordNumber = @number
	)

	delete from RecordRawText where RawNumber in (
		Select Number from RecordRaw where RecordNumber = @number
	)

	delete from RecordRaw where RecordNumber = @number

	Delete FROM [dbo].[Record] where [Number] = @number

	commit tran t1
END

