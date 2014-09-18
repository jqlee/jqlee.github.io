
CREATE PROCEDURE [dbo].[sp_ErrorLog_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 *
	FROM [dbo].[ErrorLog]
	where [Number] = @number
END

