
CREATE PROCEDURE [dbo].[sp_LanguageKey_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [FileName], [Key], [DefaultValue]
	FROM [dbo].[LanguageKey]
	where [Number] = @number
END

