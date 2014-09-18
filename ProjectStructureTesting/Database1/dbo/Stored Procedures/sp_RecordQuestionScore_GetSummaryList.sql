
CREATE PROCEDURE [dbo].[sp_RecordQuestionScore_GetSummaryList]
	@targetNumber int
AS
BEGIN
	SET NOCOUNT ON;

	select q.Title as QuestionTitle, ts.* 
	from fn_GetTargetScore(@targetNumber) ts 
	inner join Question q on q.Number = ts.QuestionNumber
	where Percentage > 0
	order by q.SortOrder
	/*
	select x.StoreNumber, x.PublishNumber, x.QuestionNumber, q.Title as QuestionTitle
	, x.TotalGainScore/x.RecordCount as FinalAverage
	from Question q
	inner join (
		select rt.Number as StoreNumber,sc.PublishNumber, rqs.QuestionNumber
		, count(distinct rqs.RecordNumber) as RecordCount
		, Sum(RawScore*QuestionScoreSetting/100) as TotalGainScore
		--rqs.* 
		from RecordTarget rt
			inner join RecordQuestionScore rqs on rqs.IndexNumber = rt.IndexNumber
			inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber and rsi.IsPublished = 1
			inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
			inner join Question q on q.Number = rqs.QuestionNumber
		where rt.Number = @recordTargetNumber
		group by rt.Number, sc.PublishNumber,rqs.QuestionNumber
	) x on x.QuestionNumber = q.Number
	order by q.SortOrder
	*/
END
/*
declare @recordTargetNumber int = 1023 --1048 2002 2006 2025
select x.RecordTargetNumber, x.QuestionNumber, q.Title as QuestionTitle, x.TotalGainScore/x.RecordCount as FinalAverage
from Question q
inner join (
	select rs.Number as RecordTargetNumber,rqs.QuestionNumber
	, count(distinct rqs.RecordNumber) as RecordCount
	, Sum(RawScore*QuestionScoreSetting/100) as TotalGainScore
	--rqs.* 
	from RecordScore rs
		inner join RecordQuestionScore rqs on rqs.IndexNumber = rs.IndexNumber
		inner join RecordScoreIndex rsi on rsi.Number = rs.IndexNumber and rsi.IsPublished = 1
		inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
		inner join Question q on q.Number = rqs.QuestionNumber
	where rs.Number = @recordTargetNumber
	group by rs.Number,rqs.QuestionNumber
) x on x.QuestionNumber = q.Number 
order by q.SortOrder

select * from RecordTarget where indexnumber = 130
select * from RecordQuestionScore where indexnumber = 130

select * from RecordRaw w
inner join RecordRawValue v on v.RawNumber = w.Number
where w.QuestionNumber = 1028 and w.SubsetNumber = 2268 and w.GroupingNumber = 0

select * from RecordTarget where Number in (2175,2179,2198)

declare @recordTargetNumber int = 2175 --1048 2002 2006 2025
exec sp_RecordQuestionScore_GetSummaryList @recordTargetNumber
exec sp_RecordQuestionScore_GetSummaryList @recordTargetNumber
*/
