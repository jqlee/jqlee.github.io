-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[del_sp_Export_GetScoreListByQuestionArea]
	-- Add the parameters for the stored procedure here
	@surveyNumber int = 0
	,@logNumber int = 0
	,@matchKey varchar(100) = null
	,@questionNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (@questionNumber = 0) set @questionNumber = null;


	select q.FullTitle, q.Title as QuestionTitle, q.AreaTitle, q.FullTitle as QuestionFullTitle
	,x.QuestionNumber, x.SubsetNumber,x.GroupingNumber
	, x.PickCount
	,x.AverageScore as QuestionAreaAverageScore
	, x.StandardDeviation as QuestionAreaStandardDeviation
	,(isNull(x.AverageScore,0)*qs.Score/100) as QuestionScore
	,qs.Score as QuestionRatio
	from fnScoreForQuestionArea(@surveyNumber, @logNumber, @matchKey) x
	left outer join (
		select qs.QuestionNumber, qs.Score from ScoreLog sl
		inner join QuestionScore qs on qs.ConfigNumber = sl.ConfigNumber
		where sl.Number = @logNumber
	) qs on qs.QuestionNumber = x.QuestionNumber
	inner join v_QuestionUnit q on q.QuestionNumber = x.QuestionNumber and q.SubsetNumber = x.SubsetNumber and q.GroupingNumber = x.GroupingNumber

return;
/*

	select x.*, q.Title as QuestionTitle,q.SubsetNumber,q.GroupingNumber 
	from (
		select MatchKey
		,SurveyNumber,x.QuestionNumber,x.SubsetNumber,x.GroupingNumber,qs.Score as QuestionRatio
		, isNull(avg(x.QuestionScore),0) as QuestionAverageScore
		, isNull(avg(x.QuestionScore)*qs.Score/100,0) as QuestionScore
		, isNull(avg(x.StandardDeviation),0) as QuestionStandardDeviation
		from (
			select sms.MatchKey
			, sms.SurveyNumber --, sl.ConfigNumber
			, sr.QuestionNumber, sr.SubsetNumber,sr.GroupingNumber
			,sr.PickCount , sr.QuestionScore, StandardDeviation
			from ScoreMatchStatus sms
			--inner join ScoreLog sl on sl.SurveyNumber = sms.SurveyNumber and sl.Number = sms.LogNumber 
			--inner join v_QuestionUnit q on q.SurveyNumber = sms.SurveyNumber
			left outer join (
				--ScoreRaw
				select sr.QuestionNumber,sr.SubsetNumber,sr.GroupingNumber 
				,count(sr.RecordNumber) as PickCount
				,avg(sr.ChoiceScore) as QuestionScore
				,stdev(sr.ChoiceScore) as StandardDeviation
				from ScoreRaw sr
				inner join Record r on r.Number = sr.RecordNumber
				where sr.SurveyNumber = @surveyNumber and sr.LogNumber =@logNumber
					and r.MatchKey = @matchKey and r.Done = 1
				group by sr.QuestionNumber,sr.SubsetNumber,sr.GroupingNumber 

			) sr on sr.QuestionNumber = q.QuestionNumber and sr.SubsetNumber = q.SubsetNumber and sr.GroupingNumber = q.GroupingNumber

			where sms.SurveyNumber = @surveyNumber and sms.LogNumber = @logNumber
				and sms.MatchKey = isNull(@matchKey, sms.MatchKey)
				--and q.QuestionNumber = isNull(@questionNumber, q.QuestionNumber)

		) x
		inner join QuestionScore qs on qs.QuestionNumber = x.QuestionNumber and qs.ConfigNumber = x.ConfigNumber
		group by MatchKey
		,SurveyNumber,x.QuestionNumber,x.SubsetNumber,x.GroupingNumber,qs.Score
	) x
	inner join v_QuestionUnit q on q.QuestionNumber = x.QuestionNumber and q.SubsetNumber = x.SubsetNumber and q.GroupingNumber = x.GroupingNumber
	--inner join Question q on q.Number = x.QuestionNumber

*/
/*
	select x.*, q.Title as QuestionTitle, q.AreaTitle, q.FullTitle as QuestionFullTitle from (
		select sms.MatchKey , s.Number as SurveyNumber, q.QuestionNumber,q.SubsetNumber,q.GroupingNumber
			,sr.PickCount , sr.QuestionScore, StandardDeviation

		from Survey s
		inner join ScoreLog sl on sl.SurveyNumber = s.Number
		inner join ScoreMatchStatus sms on sms.SurveyNumber = s.Number and sms.LogNumber = sl.Number
		inner join v_QuestionUnit q on q.SurveyNumber = s.Number
		inner join (
			--ScoreRaw
			select r.MatchKey, sr.SurveyNumber, sr.LogNumber
			,sr.QuestionNumber,sr.SubsetNumber,sr.GroupingNumber 
			,count(sr.RecordNumber) as PickCount
			,avg(sr.ChoiceScore) as QuestionScore
			,stdev(sr.ChoiceScore) as StandardDeviation
			from ScoreRaw sr
			inner join Record r on r.Number = sr.RecordNumber
			where sr.SurveyNumber = @surveyNumber and sr.LogNumber =@logNumber
			 and r.MatchKey = @matchKey and r.Done = 1
			group by r.MatchKey, sr.SurveyNumber, sr.LogNumber
			,sr.QuestionNumber,sr.SubsetNumber,sr.GroupingNumber 

		) sr on sr.SurveyNumber = sms.SurveyNumber and sr.LogNumber = sms.LogNumber
		and sr.QuestionNumber = q.QuestionNumber and sr.SubsetNumber = q.SubsetNumber and sr.GroupingNumber = q.GroupingNumber

		where s.Number = @surveyNumber and sl.Number = @logNumber
		and sms.MatchKey = isNull(@matchKey, sms.MatchKey)
		and q.QuestionNumber = isNull(@questionNumber, q.QuestionNumber)
	) x
	inner join v_QuestionUnit q on q.QuestionNumber = x.QuestionNumber and q.SubsetNumber = x.SubsetNumber and q.GroupingNumber = x.GroupingNumber
*/

END
