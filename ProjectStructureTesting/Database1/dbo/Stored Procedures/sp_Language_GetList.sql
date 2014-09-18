
CREATE PROCEDURE [dbo].[sp_Language_GetList]
	@enabled bit = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [Name], [Code], [Enabled]
	FROM [dbo].[Language]
	where [Enabled] = isNull(@enabled,[Enabled])
END
