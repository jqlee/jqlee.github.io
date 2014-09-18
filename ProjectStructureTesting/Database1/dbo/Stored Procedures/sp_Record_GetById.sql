
CREATE PROCEDURE [dbo].[sp_Record_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 *
	FROM [dbo].[Record]
	where [Number] = @number
END

