
CREATE PROCEDURE [dbo].[sp_LanguageKey_GetLanguageList]
	@fileName nvarchar(100) = null
	,@languageNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT k.[Number], k.[FileName], k.[Key], k.[DefaultValue], @languageNumber as [LanguageNumber]
	, d.Value
	FROM [dbo].[LanguageKey] k
	left outer join [dbo].[LanguageData] d on d.KeyNumber = k.Number and d.LanguageNumber = @languageNumber
	where k.[FileName] = isNull(@fileName,k.[FileName])
	order by k.[Key]
END
