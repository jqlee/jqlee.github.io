
CREATE PROCEDURE [dbo].[sp_LanguageData_Delete]
	@languageNumber int = null
	,@keyNumber int = null
	
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[LanguageData] where [LanguageNumber] = @languageNumber and [KeyNumber] = @keyNumber 
END