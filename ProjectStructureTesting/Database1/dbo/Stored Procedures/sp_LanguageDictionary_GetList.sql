
CREATE PROCEDURE [dbo].[sp_LanguageDictionary_GetList]
	@fileName nvarchar(100) = null
	,@key nvarchar(100) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [FileName], [Key], [DefaultText]
	FROM [dbo].[LanguageDictionary]
	where [FileName] = isNull(@fileName,[FileName])
	 and [Key] = isNull(@key,[Key])
END
