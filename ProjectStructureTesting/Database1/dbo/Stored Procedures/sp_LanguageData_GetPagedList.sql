
CREATE PROCEDURE [dbo].[sp_LanguageData_GetPagedList]
	@languageNumber int = null
	,@dictionaryKey varchar(100) = null
	,@value nvarchar(MAX) = null 
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	--若參數型別對應到.net的實值型別，並且參數允許null，請務必檢查is null並給預設值
	--if (@int is null) set @int = -1; 

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'[LanguageData]' --table
	, '[Number], [LanguageNumber], [DictionaryKey], [Value]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [LanguageNumber] = isNull(@languageNumber,[LanguageNumber])
	 and [DictionaryKey] = isNull(@dictionaryKey,[DictionaryKey])
	 and [Value] = isNull(@value,[Value])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@languageNumber int, @dictionaryKey varchar(100), @value nvarchar(MAX),@startRowIndex int,@maximumRows int , @recordCount int output'
		,@languageNumber=@languageNumber , @dictionaryKey=@dictionaryKey , @value=@value ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

