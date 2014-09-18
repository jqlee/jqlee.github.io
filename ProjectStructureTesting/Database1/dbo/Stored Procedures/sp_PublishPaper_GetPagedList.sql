
CREATE PROCEDURE [dbo].[sp_PublishPaper_GetPagedList]
	@publishNumber int = null
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
	'[PublishPaper]' --table
	, '[Number], [Title], [Description], [Created], [PublishNumber], [CopySource], [Guid]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [PublishNumber] = isNull(@publishNumber,[PublishNumber])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@publishNumber int, @startRowIndex int,@maximumRows int , @recordCount int output'
		,@publishNumber=@publishNumber ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

