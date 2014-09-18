
CREATE PROCEDURE [dbo].[sp_RecordRawText_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[RecordRawText] where [Number] = @number
END