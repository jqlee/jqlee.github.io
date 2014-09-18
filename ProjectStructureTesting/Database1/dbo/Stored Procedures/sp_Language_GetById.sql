
CREATE PROCEDURE [dbo].[sp_Language_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [Name], [Code], [Enabled]
	FROM [dbo].[Language]
	where [Number] = @number
END

