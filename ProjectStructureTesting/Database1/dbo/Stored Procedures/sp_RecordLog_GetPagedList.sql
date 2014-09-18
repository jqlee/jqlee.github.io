
CREATE PROCEDURE [dbo].[sp_RecordLog_GetPagedList]
	@surveyNumber int = null
	,@recordNumber int = null
	,@itemNumber int = null
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	--若參數型別對應到.net的實值型別，並且參數允許null，請務必檢查is null並給預設值
	--if (@int is null) set @int = -1; 
	if (@surveyNumber = 0) set @surveyNumber = null;
	if (@recordNumber = 0) set @recordNumber = null;
	if (@itemNumber = 0) set @itemNumber = null;

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'[RecordLog]' --table
	, '[Number], [SurveyNumber], [RecordNumber], [ItemNumber], [TextAnswer]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
	 and [RecordNumber] = isNull(@recordNumber,[RecordNumber])
	 and [ItemNumber] = isNull(@itemNumber,[ItemNumber])
	 ' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@surveyNumber int, @recordNumber int, @itemNumber int, @startRowIndex int,@maximumRows int , @recordCount int output'
		,@surveyNumber=@surveyNumber , @recordNumber=@recordNumber , @itemNumber=@itemNumber ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

