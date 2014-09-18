
CREATE PROCEDURE [dbo].[sp_LanguageData_GetById]
	@languageNumber int = 0
	,@keyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [LanguageNumber], [KeyNumber], [Value]
	FROM [dbo].[LanguageData]
	where [LanguageNumber] = @languageNumber
	 and [KeyNumber] = @keyNumber
END

