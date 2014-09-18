
CREATE PROCEDURE [dbo].[sp_Department_GetPagedList]
	@id varchar(8) = null
	,@name nvarchar(150) = null
	,@shortName nvarchar(20) = null 
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
	'[v_Department]' --table
	, '[Id], [Name], [ShortName]' --reutrn columns
	, '' --sortExpressions
	, 'where [Id] = isNull(@id,[Id])
	 and [Name] = isNull(@name,[Name])
	 and [ShortName] = isNull(@shortName,[ShortName])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@id varchar(8), @name nvarchar(150), @shortName nvarchar(20),@startRowIndex int,@maximumRows int , @recordCount int output'
		,@id=@id , @name=@name , @shortName=@shortName ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END


