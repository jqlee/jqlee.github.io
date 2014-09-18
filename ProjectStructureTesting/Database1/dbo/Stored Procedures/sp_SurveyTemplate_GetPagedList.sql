
CREATE PROCEDURE [dbo].[sp_SurveyTemplate_GetPagedList]
	@creator varchar(20) = null
	,@keyword nvarchar(50) = null
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
	'[SurveyTemplate]' --table
	, '[Number], [Title], [Description], [Enabled], [Creator], [Created], [LastModified], [Guid]' --reutrn columns
	, '[LastModified] desc' --sortExpressions
	, 'where [Creator] = isNull(@creator,[Creator]) and 1 = (case when @keyword is null then 1 when [Title] like ''%''+@keyword+''%'' or [Description] like ''%''+@keyword+''%'' then 1 else 0 end) ' --where conditions
	)
	--print @sql;
	EXECUTE sp_executesql @sql, N'@creator varchar(20),@keyword nvarchar(50),@startRowIndex int,@maximumRows int , @recordCount int output'
		,@creator=@creator,@keyword=@keyword,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END



--exec sp_SurveyTemplate_GetPagedList 'atchao', null, 1, 10, @recordCount=0
