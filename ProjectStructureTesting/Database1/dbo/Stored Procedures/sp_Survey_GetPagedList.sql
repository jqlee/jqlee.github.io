
CREATE PROCEDURE [dbo].[sp_Survey_GetPagedList]
	@stateMark tinyint = 0
	,@creator varchar(20) = null
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	--若參數型別對應到.net的實值型別，並且參數允許null，請務必檢查is null並給預設值
	if (@stateMark = 0) set @stateMark = null; 

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'[Survey]' --table
	, '[Number], [Name], [Creator], [Created]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [Creator] = isNull(@creator,[Creator])
	  and s.[StateMark] = isNull(@stateMark, s.[StateMark])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@stateMark tinyint, @creator varchar(20),@startRowIndex int,@maximumRows int , @recordCount int output'
		,@stateMark=@stateMark , @creator=@creator ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END


