
create PROCEDURE [dbo].[sp_LanguageKey_GetFileList]
	
AS
BEGIN
	SET NOCOUNT ON;
	SELECT distinct [FileName]
	FROM [dbo].[LanguageKey]
	order by [FileName]
END
