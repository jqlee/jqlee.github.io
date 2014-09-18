
CREATE PROCEDURE [dbo].[sp_TargetDepartment_GetPagedList]
	@surveyNumber int = null
	,@departmentId varchar(20) = null
	,@level varchar(2) = null 
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
	'[TargetDepartment]' --table
	, '[Number], [SurveyNumber], [DepartmentId], [Level]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
	 and [DepartmentId] = isNull(@departmentId,[DepartmentId])
	 and [Level] = isNull(@level,[Level])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@surveyNumber int, @departmentId varchar(20), @level varchar(2),@startRowIndex int,@maximumRows int , @recordCount int output'
		,@surveyNumber=@surveyNumber , @departmentId=@departmentId , @level=@level ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END


