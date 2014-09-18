
CREATE PROCEDURE [dbo].[sp_LanguageDictionary_GetPagedList]
	@fileName nvarchar(100) = null
	,@key nvarchar(100) = null
	,@defaultText nvarchar(MAX) = null 
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
	'[LanguageDictionary]' --table
	, '[Number], [FileName], [Key], [DefaultText]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [FileName] = isNull(@fileName,[FileName])
	 and [Key] = isNull(@key,[Key])
	 and [DefaultText] = isNull(@defaultText,[DefaultText])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@fileName nvarchar(100), @key nvarchar(100), @defaultText nvarchar(MAX),@startRowIndex int,@maximumRows int , @recordCount int output'
		,@fileName=@fileName , @key=@key , @defaultText=@defaultText ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

