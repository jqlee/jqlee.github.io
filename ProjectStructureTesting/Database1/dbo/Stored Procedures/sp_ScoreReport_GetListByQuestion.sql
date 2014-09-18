-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetListByQuestion]
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier 
	,@memberCount int = 0
	,@groupId varchar(20) = null
	,@groupRole varchar(6) = null
	,@teacherId varchar(20) = null
	/* 人員問卷先不作 */
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- 可能要把configNumber跟IndexNumber提出來先查好，方便在外層找target

	-- 題組的數字都是子題的平均

select q.Title as QuestionTitle
--, qs.Score as QuestionMaxScore
,x.* from (
	select ConfigNumber, IndexNumber, QuestionNumber, QuestionScoreSetting, QuestionItemCount
		,SUM(AnswerCount) as QuestionAnswerCount -- TotalAnswerCount/ QuestionItemCount = 題組回答率
		--,Convert(float,SUM(AnswerCount))/QuestionItemCount as AnswerCount
		,@memberCount as MemberCount
		,AVG(AvgScore) as AvgScore, AVG(StdevScore) as StdevScore, AVG(StdevpScore) as StdevpScore
		, QuestionScoreSetting / 100 * AVG(AvgScore) as FinalScore
	from (
		select ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber, @memberCount as MemberCount
			, count(distinct RecordNumber) as AnswerCount
			, count(distinct RecordNumber)/@memberCount as AnswerRate
			, AVG(TotalScore) as AvgScore , STDEV(TotalScore) as StdevScore , STDEVP(TotalScore) as StdevpScore
			, QuestionScoreSetting, QuestionItemCount
		from (
			select rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber, sum((rs.RawScore)) as TotalScore
			,rs.QuestionScoreSetting,rs.QuestionItemCount
			from RecordScoreIndex rsi
			inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
			inner join Record r on r.Number = rs.RecordNumber
			where rsi.[Guid] = @indexGuid and rs.RawScore is not null
			 and r.[GroupId] = isNull(@groupId, [GroupId])
			 and r.[GroupRole] = isNull(@groupRole, [GroupRole])
			 and r.[GroupTeacherId] = isNull(@teacherId, [GroupTeacherId])
			group by rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber,rs.QuestionScoreSetting,rs.QuestionItemCount
		) x
		group by ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber,QuestionScoreSetting,QuestionItemCount
	) x
	group by ConfigNumber, IndexNumber, QuestionNumber, QuestionScoreSetting, QuestionItemCount
/*
	select ConfigNumber, IndexNumber, QuestionNumber, QuestionScoreSetting, QuestionItemCount, @memberCount as MemberCount
		, count(RecordNumber) as RecordCount, AVG(TotalScore) as AvgScore , STDEV(TotalScore) as StdevScore , STDEVP(TotalScore) as StdevpScore
	from (
		select rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber,rs.QuestionScoreSetting,rs.QuestionItemCount, sum((rs.RawScore)/rs.QuestionItemCount) as TotalScore
		from RecordScoreIndex rsi
		inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
		inner join Record r on r.Number = rs.RecordNumber
		where rsi.[Guid] = @indexGuid and rs.RawScore is not null
		 and r.[GroupId] = isNull(@groupId, [GroupId])
		 and r.[GroupRole] = isNull(@groupRole, [GroupRole])
		 and r.[GroupTeacherId] = isNull(@teacherId, [GroupTeacherId])
		group by rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber,rs.QuestionScoreSetting,rs.QuestionItemCount
	) x
	group by ConfigNumber, IndexNumber, QuestionNumber, QuestionScoreSetting, QuestionItemCount
*/
) x
inner join Question q on q.Number = x.QuestionNumber
--inner join QuestionScore qs on qs.QuestionNumber = x.QuestionNumber and qs.ConfigNumber = x.ConfigNumber
order by q.SortOrder



END


/*
DECLARE @indexGuid uniqueidentifier = '89677108-68e0-4292-918e-697247da6c5b'
	,@memberCount int = 4
	,@groupId varchar(20) = '982CMNCT20D57900'
	,@groupRole varchar(6) = '1000'
	,@teacherId varchar(20) = 'T8900167'

exec sp_ScoreReport_GetListByQuestion @indexGuid,@memberCount,@groupId,@groupRole,@teacherId


DECLARE @indexGuid uniqueidentifier = '6199c241-114a-496c-ab1f-5836d5544538'
	,@memberCount int = 4


exec sp_ScoreReport_GetListByQuestion @indexGuid,@memberCount

*/