
CREATE PROCEDURE [dbo].[sp_TargetCondition_GetPagedList]
	@surveyNumber int = null
	,@targetMark tinyint = null
	,@name varchar(20) = null
	,@data varchar(20) = null
	,@roleCode varchar(6) = null 
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
	'[TargetCondition]' --table
	, '[Number], [SurveyNumber], [TargetMark], [Name], [Data], [RoleCode]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
	 and [TargetMark] = isNull(@targetMark,[TargetMark])
	 and [Name] = isNull(@name,[Name])
	 and [Data] = isNull(@data,[Data])
	 and [RoleCode] = isNull(@roleCode,[RoleCode])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@surveyNumber int, @targetMark tinyint, @name varchar(20), @data varchar(20), @roleCode varchar(6),@startRowIndex int,@maximumRows int , @recordCount int output'
		,@surveyNumber=@surveyNumber , @targetMark=@targetMark , @name=@name , @data=@data , @roleCode=@roleCode ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

