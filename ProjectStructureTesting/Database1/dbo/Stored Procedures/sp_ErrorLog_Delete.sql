
CREATE PROCEDURE [dbo].[sp_ErrorLog_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[ErrorLog] where [Number] = @number
END