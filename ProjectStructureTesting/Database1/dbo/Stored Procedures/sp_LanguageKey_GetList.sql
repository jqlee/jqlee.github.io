
CREATE PROCEDURE [dbo].[sp_LanguageKey_GetList]
	@fileName nvarchar(100) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [FileName], [Key], [DefaultValue]
	FROM [dbo].[LanguageKey]
	where [FileName] = isNull(@fileName,[FileName])
	order by [Key]
END
