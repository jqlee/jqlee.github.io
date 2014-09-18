
CREATE PROCEDURE [dbo].[sp_RecordLog_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[RecordLog] where [Number] = @number
END