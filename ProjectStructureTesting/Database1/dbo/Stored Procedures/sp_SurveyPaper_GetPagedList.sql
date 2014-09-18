/*
	2014-03-17 修改為根據校別教務以上(>3000)共享問卷，影響到 1: 範本清單 2: 問卷編輯選取範本
*/
CREATE PROCEDURE [dbo].[sp_SurveyPaper_GetPagedList]
	--@creator varchar(20) = null
	@schoolId varchar(20) = null
	,@memberRole varchar(6) = null
	,@enabled bit = 1
	,@isTemplate bit = 1
	,@keyword nvarchar(max) = null
	,@sortExpressions nvarchar(max) = null
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	--若參數型別對應到.net的實值型別，並且參數允許null，請務必檢查is null並給預設值
	--if (@int is null) set @int = -1; 

	if (@sortExpressions is null or @sortExpressions = '') set @sortExpressions = 'LastModified desc'

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'[SurveyPaper]' --table
	, '[Number], [Title], [Description], [Enabled], [Creator], [Created], [LastModified],[RecycleDate], [Guid]' --reutrn columns
	, @sortExpressions --'[LastModified] desc' --sortExpressions
	, 'where [IsTemplate] = @isTemplate
	and [SchoolId] = isNull(@schoolId,[SchoolId]) and @memberRole >= ''3000'' -- and [Creator] = isNull(@creator,[Creator])
	and 1 = (case when @keyword is null then 1 
		when [Title] like ''%''+@keyword+''%'' then 1 
		when [Description] like ''%''+@keyword+''%'' then 1 
		else 0 end) 
	and 1 = (case when @enabled is null then 1 when [Enabled] = @enabled then 1 else 0 end)
	' --where conditions
	)
	print @sql;
	EXECUTE sp_executesql @sql, N'@schoolId varchar(6),@memberRole varchar(6),@enabled bit,@isTemplate bit,@keyword nvarchar(max),@sortExpressions nvarchar(max),@startRowIndex int,@maximumRows int , @recordCount int output'
		,@schoolId=@schoolId,@memberRole=@memberRole,@enabled=@enabled,@isTemplate=@isTemplate,@keyword=@keyword,@sortExpressions=@sortExpressions,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END



--exec sp_SurveyTemplate_GetPagedList 'atchao', null, 1, 10, @recordCount=0
/*
update SurveyPaper set SchoolId = '1000' where SchoolId is null
*/


/*




declare @schoolId varchar(20) = '1000'
	,@memberRole varchar(20) = '3000'
	,@enabled bit = 1
	,@isTemplate bit = 1
	,@keyword nvarchar(max) = null
	,@sortExpressions nvarchar(max) = null
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int = 0
exec sp_SurveyPaper_GetPagedList @schoolId,@memberRole,@enabled,@isTemplate,@keyword,@sortExpressions,@startRowIndex,@maximumRows,@recordCount

*/