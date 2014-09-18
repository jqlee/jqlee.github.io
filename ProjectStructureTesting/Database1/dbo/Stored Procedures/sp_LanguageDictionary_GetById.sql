
CREATE PROCEDURE [dbo].[sp_LanguageDictionary_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [FileName], [Key], [DefaultText]
	FROM [dbo].[LanguageDictionary]
	where [Number] = @number
END

