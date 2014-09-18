
CREATE PROCEDURE [dbo].[sp_LanguageData_GetList]
	@languageNumber int = 0
	,@keyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	if (@languageNumber = 0) set @languageNumber = null;
	if (@keyNumber = 0) set @keyNumber = null;
	SELECT [Number], [LanguageNumber], [KeyNumber], [Value]
	FROM [dbo].[LanguageData]
	where [LanguageNumber] = isNull(@languageNumber, [LanguageNumber])
	 and [KeyNumber] = isNull(@keyNumber, [KeyNumber])
END
