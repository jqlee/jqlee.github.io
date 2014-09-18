
CREATE PROCEDURE [dbo].[sp_RecordRawValue_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[RecordRawValue] where [Number] = @number
END