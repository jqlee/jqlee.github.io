-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec sp_Export_GetMatchScoreList 1246,224,null,1
-- =============================================
CREATE PROCEDURE [dbo].[del_sp_Export_GetMatchScoreList]
	-- Add the parameters for the stored procedure here
	@surveyNumber int 
	,@logNumber int
	--,@matchKey varchar(50) = null
	,@keyword nvarchar(50) = null
	, @showEmpty bit = 1
	--,@matchFilter int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	
	select sms.MatchKey,sms.MatchName, sms.MemberCount, sms.RecordCount
	, isNull(lms.AverageScore,0) as AverageScore, isNull(lms.StandardDeviation ,0) as StandardDeviation
	from ScoreMatchStatus sms 
	left outer join fn_ListMatchScore(@surveyNumber, @logNumber) lms on lms.MatchKey = sms.MatchKey
	where sms.SurveyNumber = @surveyNumber and sms.LogNumber = @logNumber
		--and sms.MatchKey = isNull(@matchKey, sms.MatchKey)
		and (case when @keyword is not null and sms.MatchName like '%'+@keyword+'%' then 1 when @keyword is null then 1 else 0 end =1)
	and (case when @showEmpty = 0 and lms.MatchKey is null then 0 else 1 end) = 1

	/*

	select @surveyNumber as [SurveyNumber],tm.TargetNumber, tm.MatchKey, tm.MatchFilter, tm.MatchName
	, isNull(x.Section,0) as [Section]
	--,q.QuestionNumber,q.Section, q.SubsetNumber,q.GroupingNumber
	--,q.FullTitle as QuestionTitle
	--,c.Number as ChoiceNumber,c.[Text] as ChoiceText
	,isNull(x.PickCount,0) as PickCount
	,isNull(x.TotalScore,0) as TotalScore
	,isNull(x.AverageScore,0) as AverageScore
	,isNull(x.StandardDeviation,0) as StandardDeviation
	from --v_QuestionUnit q	inner join 
	dbo.fnTargetMatch(@surveyNumber) tm --on tm.SurveyNumber = q.SurveyNumber
	--inner join v_Choice c on c.QuestionNumber = q.QuestionNumber
	left outer join (
		select w.MatchKey,w.MatchFilter, w.Section --, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber--, w.ChoiceNumber
		,count(w.RecordNumber) as PickCount
		, sum(w.ChoiceScore) as TotalScore
		, avg(w.ChoiceScore) as AverageScore
		, STDEVP(w.ChoiceScore) as StandardDeviation
		from v_ScoreRaw w
		where w.SurveyNumber = @surveyNumber and w.LogNumber = @logNumber
		group by w.MatchKey,w.MatchFilter, w.Section
		--, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber
		--, w.ChoiceNumber
		--order by w.MatchKey,w.MatchFilter, w.Section, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber, w.ChoiceNumber
	) x on x.MatchKey = tm.MatchKey and x.MatchFilter = tm.MatchFilter
	 --and x.QuestionNumber = q.QuestionNumber and x.SubsetNumber = q.SubsetNumber and x.GroupingNumber = q.GroupingNumber
	-- and x.ChoiceNumber = c.Number
	where tm.SurveyNumber= @surveyNumber -- and q.QuestionNumber=380 and q.SubsetNumber = 1161 and q.GroupingNumber = 0 
	and tm.MatchKey = @matchKey and tm.MatchFilter = @matchFilter
	order by tm.[Index], x.Section--, q.SortOrder--, c.SortOrder

	*/

END

