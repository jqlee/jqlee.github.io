
CREATE PROCEDURE [dbo].[sp_LanguageData_GetForModify]
	@languageNumber int = 0
	,@keyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 d.[Number]
	, @languageNumber as [LanguageNumber]
	,l.Name as LanguageName
	, @keyNumber as [KeyNumber]
	, k.[Key] as [KeyText]
	, d.[Value]
	FROM [dbo].[Language] l
	inner join [dbo].[LanguageKey] k on k.Number = @keyNumber
	left outer join [dbo].[LanguageData] d on d.[LanguageNumber] = l.Number and d.[KeyNumber] = @keyNumber
	where l.Number = @languageNumber 
END