
CREATE PROCEDURE [dbo].[sp_TargetForDepartment_GetPagedList]
	@surveyNumber int = null
	,@departmentId varchar(50) = null
	,@memberGrade int = null
	,@groupYear int = null
	,@targetMark tinyint = null 
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
	'[TargetForDepartment]' --table
	, '[Number], [SurveyNumber], [DepartmentId], [MemberGrade], [GroupYear], [TargetMark]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
	 and [DepartmentId] = isNull(@departmentId,[DepartmentId])
	 and [MemberGrade] = isNull(@memberGrade,[MemberGrade])
	 and [GroupYear] = isNull(@groupYear,[GroupYear])
	 and [TargetMark] = isNull(@targetMark,[TargetMark])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@surveyNumber int, @departmentId varchar(50), @memberGrade int, @groupYear int, @targetMark tinyint,@startRowIndex int,@maximumRows int , @recordCount int output'
		,@surveyNumber=@surveyNumber , @departmentId=@departmentId , @memberGrade=@memberGrade , @groupYear=@groupYear , @targetMark=@targetMark ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

