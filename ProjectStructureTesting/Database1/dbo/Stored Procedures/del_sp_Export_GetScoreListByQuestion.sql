-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[del_sp_Export_GetScoreListByQuestion]
	-- Add the parameters for the stored procedure here
	@surveyNumber int = 0
	,@logNumber int = 0
	,@matchKey varchar(100) = null
--	,@matchFilter int = 0
	,@questionNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (@questionNumber = 0) set @questionNumber = null;
	
	
	select ROW_NUMBER() over(order by q.SortOrder) as RowIndex
	, x.AverageScore as QuestionAverageScore
	, x.StandardDeviation as QuestionStandardDeviation
	, x.*, q.Title as QuestionTitle
	from fnMatchScoreForQuestion(@surveyNumber,@logNumber) x
	inner join Question q on q.Number = x.QuestionNumber
	where x.MatchKey = isNull(@matchKey, x.MatchKey)
	/*

	select x.*, q.Title as QuestionTitle from (
		select MatchKey
		,SurveyNumber,x.QuestionNumber,qs.Score as QuestionRatio
		, isNull(avg(x.QuestionScore),0) as QuestionAverageScore
		, isNull(avg(x.QuestionScore)*qs.Score/100,0) as QuestionScore
		, isNull(avg(x.StandardDeviation),0) as QuestionStandardDeviation
		from (
		select sms.MatchKey
		, sms.SurveyNumber, sl.ConfigNumber, q.QuestionNumber, q.SubsetNumber,q.GroupingNumber
		,sr.PickCount , sr.QuestionScore, StandardDeviation
		from  ScoreMatchStatus sms
		inner join ScoreLog sl on sl.SurveyNumber = sms.SurveyNumber and sl.Number = sms.LogNumber 
		inner join v_QuestionUnit q on q.SurveyNumber = sms.SurveyNumber
		left outer join (
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

		where sms.SurveyNumber = @surveyNumber and sms.LogNumber = @logNumber
			and sms.MatchKey = isNull(@matchKey, sms.MatchKey)
			and q.QuestionNumber = isNull(@questionNumber, q.QuestionNumber)

			) x
		inner join QuestionScore qs on qs.QuestionNumber = x.QuestionNumber and qs.ConfigNumber = x.ConfigNumber
		group by MatchKey
		,SurveyNumber,x.QuestionNumber,qs.Score
	) x
	inner join Question q on q.Number = x.QuestionNumber
	*/
END
