-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[del_sp_Export_GetScoreListByMatch]
	-- Add the parameters for the stored procedure here
	@surveyNumber int = 0
	,@logNumber int = 0
	,@matchKey varchar(100) = null
	--,@matchFilter int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--if (@matchFilter = 0) set @matchFilter = null;
	--if (@targetNumber = 0) set @targetNumber = null;

	select * 
	from ScoreMatchStatus sms
	left outer join fnMatchScoreForSurvey(@surveyNumber,@logNumber) x on x.MatchKey = sms.MatchKey
	where sms.SurveyNumber = @surveyNumber and sms.LogNumber = @logNumber and x.matchKey = @matchKey


	/*
	
	, (select sum(qs.Score) from ScoreLog sl inner join QuestionScore qs on qs.ConfigNumber = sl.ConfigNumber
where sl.Number = @logNumber) as TotalQuestionRatio
	from ScoreMatchStatus sms
	left outer join (
		select r.MatchKey
		, count(sr.Number) as [PickCount]
		, avg(ChoiceScore) as [AverageScore]
		, stdev(ChoiceScore) as [StandardDeviation]
		from ScoreRaw sr
		inner join Record r on r.Number = sr.RecordNumber
		where sr.SurveyNumber = @surveyNumber and LogNumber = @logNumber and r.MatchKey = @matchKey
		and r.Done = 1
		group by r.MatchKey
	) x on x.MatchKey = sms.MatchKey
	where sms.SurveyNumber = @surveyNumber and sms.LogNumber = @logNumber and sms.MatchKey = @matchKey
	*/

	/*
	select * from ScoreMatchStatus

	select x.*,sms.MatchName,sms.FilterName 
	, (select sum(qs.Score) from ScoreLog sl inner join QuestionScore qs on qs.ConfigNumber = sl.ConfigNumber
where sl.Number = @logNumber) as TotalQuestionRatio
	from (
		select MatchKey, MemberCount, RecordCount
			, isNull(sum(QuestionScore),0) as SurveyScore
			,isNull(stdev(AverageScore),0) as [StandardDeviationOfAverageScore] --所有題目平均分作標準差
			,isNull(avg(QuestionStDev),0) as [AverageScoreOfStandardDeviation] --所有題目平均分作標準差
			--最外層這個標準差，還要再考慮到底是要用題目標準差的平均，或是直接把所有題目平均分作標準差。
		from (
			select MatchKey, MemberCount, RecordCount,SurveyNumber,x.QuestionNumber,qs.Score as QuestionRatio
			, avg(x.QuestionScore) as AverageScore 
			, avg(x.QuestionScore)*qs.Score/100 as QuestionScore
			, stdev(x.QuestionScore) as QuestionStDev 
			
			from (
				select sms.MatchKey
				, sms.MemberCount, sms.RecordCount
				, sms.SurveyNumber, sl.ConfigNumber, q.QuestionNumber, q.SubsetNumber,q.GroupingNumber
				, avg(sr.ChoiceScore) as QuestionScore
				from  ScoreMatchStatus sms
				inner join ScoreLog sl on sl.SurveyNumber = sms.SurveyNumber and sl.Number = sms.LogNumber 
				inner join v_QuestionUnit q on q.SurveyNumber = sms.SurveyNumber
				left outer join ScoreRaw sr on sr.SurveyNumber = sms.SurveyNumber and sr.LogNumber = sms.LogNumber and sr.MatchKey = sms.MatchKey and sr.MatchFilter = sms.MatchFilter and sr.SubsetNumber = q.SubsetNumber and sr.GroupingNumber = q.GroupingNumber
				where sms.SurveyNumber = @surveyNumber and sms.LogNumber = @logNumber
					--and sms.targetNumber = isNull(@targetNumber, sms.targetNumber)
					and sms.MatchKey = isNull(@matchKey, sms.MatchKey)
					--and sms.MatchFilter = isNull(@matchFilter, sms.MatchFilter)
				group by sms.MatchKey, sms.MemberCount, sms.RecordCount, sms.SurveyNumber, sl.ConfigNumber, q.QuestionNumber,q.SubsetNumber,q.GroupingNumber 
			) x
			inner join QuestionScore qs on qs.QuestionNumber = x.QuestionNumber and qs.ConfigNumber = x.ConfigNumber
			group by MatchKey, x.MemberCount, x.RecordCount,SurveyNumber,x.QuestionNumber,qs.Score

		) x
		group by MatchKey, x.MemberCount, x.RecordCount
	) x
	inner join ScoreMatchStatus sms on sms.LogNumber = @logNumber 
	and sms.MatchKey = x.MatchKey

--, TotalQuestionRatio
	*/
END
