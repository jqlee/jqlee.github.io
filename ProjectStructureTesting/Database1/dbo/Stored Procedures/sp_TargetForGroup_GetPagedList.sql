
CREATE PROCEDURE [dbo].[sp_TargetForGroup_GetPagedList]
	@surveyNumber int = null
	,@groupId varchar(20) = null
	,@memberId varchar(20) = null
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
	'[TargetForGroup]' --table
	, '[Number], [SurveyNumber], [GroupId], [MemberId], [TargetMark]' --reutrn columns
	, '[Number]' --sortExpressions
	, 'where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
	 and [GroupId] = isNull(@groupId,[GroupId])
	 and [MemberId] = isNull(@memberId,[MemberId])
	 and [TargetMark] = isNull(@targetMark,[TargetMark])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@surveyNumber int, @groupId varchar(20), @memberId varchar(20), @targetMark tinyint,@startRowIndex int,@maximumRows int , @recordCount int output'
		,@surveyNumber=@surveyNumber , @groupId=@groupId , @memberId=@memberId , @targetMark=@targetMark ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

