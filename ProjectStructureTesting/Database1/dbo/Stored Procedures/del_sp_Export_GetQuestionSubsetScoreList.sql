-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[del_sp_Export_GetQuestionSubsetScoreList]
	-- Add the parameters for the stored procedure here
	@surveyNumber int 
	,@logNumber int
	,@matchKey varchar(20)
	,@matchFilter int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	
	select @surveyNumber as [SurveyNumber],tm.TargetNumber, tm.MatchKey, tm.MatchFilter, tm.MatchName
	, isNull(x.Section,0) as [Section]
	,q.QuestionNumber,q.Section, q.SubsetNumber,q.GroupingNumber
	,q.FullTitle as QuestionTitle
	--,c.Number as ChoiceNumber,c.[Text] as ChoiceText
	,isNull(x.PickCount,0) as PickCount
	,isNull(x.TotalScore,0) as TotalScore
	,isNull(x.AverageScore,0) as AverageScore
	,isNull(x.StandardDeviation,0) as StandardDeviation
	,x.QuestionScore
	,isNull(x.AverageScore,0)*x.QuestionScore/100 as QuestionFinalScore
	from v_QuestionUnit q inner join 
	ScoreMatchStatus tm on tm.SurveyNumber = q.SurveyNumber
	--dbo.fnTargetMatch(@surveyNumber) tm on tm.SurveyNumber = q.SurveyNumber
	--inner join v_Choice c on c.QuestionNumber = q.QuestionNumber
	left outer join (
		select w.MatchKey,w.MatchFilter, w.Section , w.QuestionNumber, w.SubsetNumber, w.GroupingNumber--, w.ChoiceNumber
		,w.QuestionScore
		,count(w.RecordNumber) as PickCount
		, sum(w.ChoiceScore) as TotalScore
		, avg(w.ChoiceScore) as AverageScore
		, STDEVP(w.ChoiceScore) as StandardDeviation
		from v_ScoreRaw w
		where w.SurveyNumber = @surveyNumber and w.LogNumber = @logNumber
		group by w.MatchKey,w.MatchFilter, w.Section
		, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber
		--, w.ChoiceNumber
		,w.QuestionScore
		--order by w.MatchKey,w.MatchFilter, w.Section, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber, w.ChoiceNumber
	) x on x.MatchKey = tm.MatchKey and x.MatchFilter = tm.MatchFilter
	and x.QuestionNumber = q.QuestionNumber and x.SubsetNumber = q.SubsetNumber and x.GroupingNumber = q.GroupingNumber
	-- and x.ChoiceNumber = c.Number
	where tm.SurveyNumber= @surveyNumber -- and q.QuestionNumber=380 and q.SubsetNumber = 1161 and q.GroupingNumber = 0 
	and tm.MatchKey = @matchKey and tm.MatchFilter = @matchFilter
	order by tm.[MatchKey],tm.[MatchFilter], x.Section, q.SortOrder--, c.SortOrder



END
