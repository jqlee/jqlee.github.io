
CREATE PROCEDURE [dbo].[sp_Language_GetPagedList]
	@name nvarchar(50) = null
	,@code varchar(6) = null
	,@enabled bit = null 
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
	'[Language]' --table
	, '[Number], [Name], [Code], [Enabled]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [Name] = isNull(@name,[Name])
	 and [Code] = isNull(@code,[Code])
	 and [Enabled] = isNull(@enabled,[Enabled])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@name nvarchar(50), @code varchar(6), @enabled bit,@startRowIndex int,@maximumRows int , @recordCount int output'
		,@name=@name , @code=@code , @enabled=@enabled ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

