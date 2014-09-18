
CREATE PROCEDURE [dbo].[sp_RecordRaw_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[RecordRaw] where [Number] = @number
	Delete FROM [dbo].[RecordRawValue] where [RawNumber] = @number
	Delete FROM [dbo].[RecordRawText] where [RawNumber] = @number
END