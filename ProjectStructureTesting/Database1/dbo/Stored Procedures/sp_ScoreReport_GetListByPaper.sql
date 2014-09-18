-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetListByPaper]
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier 
	,@recordCount int = 0
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

	select ConfigNumber,IndexNumber, @memberCount as MemberCount
		,@recordCount as RecordCount
		--, count(RecordNumber) as RecordCount
		--, sum(QuestionRecordCount) as RecordCount
		,SUM(FinalAvgScore) as AvgScore, SUM(FinalStdevScore) as StdevScore, SUM(FinalStdevpScore) as StdevpScore
	from (

		select ConfigNumber, IndexNumber, QuestionNumber--, QuestionScoreSetting, QuestionItemCount
			--,sum(RecordCount) as QuestionRecordCount
			,QuestionScoreSetting/100 * AVG(AvgScore) as FinalAvgScore
			, QuestionScoreSetting/100 * AVG(StdevScore) as FinalStdevScore
			, QuestionScoreSetting/100 * AVG(StdevpScore) as FinalStdevpScore
		from (
			select ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber, @memberCount as MemberCount
				, count(RecordNumber) as RecordCount, AVG(TotalScore) as AvgScore , STDEV(TotalScore) as StdevScore , STDEVP(TotalScore) as StdevpScore
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
		select rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, sum((rs.RawScore*rs.QuestionScoreSetting/100)/rs.QuestionItemCount) as TotalScore
		from RecordScoreIndex rsi
		inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
		inner join Record r on r.Number = rs.RecordNumber
		where rsi.[Guid] = @indexGuid
		 and r.[GroupId] = isNull(@groupId, [GroupId])
		 and r.[GroupRole] = isNull(@groupRole, [GroupRole])
		 and r.[GroupTeacherId] = isNull(@teacherId, [GroupTeacherId])
		group by rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber
*/
	) x
	group by ConfigNumber,IndexNumber

END

/*
DECLARE @indexGuid uniqueidentifier = '89677108-68e0-4292-918e-697247da6c5b'
	,@memberCount int = 0
	,@recordCount int = 0
	,@groupId varchar(20) = '982CMNCT20D57900'
	,@groupRole varchar(6) = '1000'
	,@teacherId varchar(20) = 'T8900167'

exec sp_ScoreReport_GetListByPaper @indexGuid=@indexGuid,@memberCount=@memberCount,@recordCount=@recordCount,@groupId=@groupId,@groupRole=@groupRole,@teacherId=@teacherId

select ConfigNumber,IndexNumber, @memberCount as MemberCount
	, count(RecordNumber) as RecordCount, AVG(TotalScore) as AvgScore , STDEV(TotalScore) as StdevScore , STDEVP(TotalScore) as StdevpScore
from (
	select rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, sum((rs.RawScore*rs.QuestionScoreSetting/100)/rs.QuestionItemCount) as TotalScore
	from RecordScoreIndex rsi
	inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
	inner join Record r on r.Number = rs.RecordNumber
	where rsi.[Guid] = @indexGuid
		 and r.[GroupId] = isNull(@groupId, [GroupId])
		 and r.[GroupRole] = isNull(@groupRole, [GroupRole])
		 and r.[GroupTeacherId] = isNull(@teacherId, [GroupTeacherId])
	group by rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber
) x
group by ConfigNumber,IndexNumber

select * from RecordScoreIndex
select * from RecordQuestionScore
select * from Record
*/