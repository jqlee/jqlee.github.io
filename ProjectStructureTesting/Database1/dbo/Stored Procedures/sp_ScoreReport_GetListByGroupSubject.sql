-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetListByGroupSubject]
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier 
	,@groupId varchar(20) = null
	/*
	,@groupId varchar(20) = null
	,@groupRole varchar(6) = null
	,@teacherId varchar(20) = null
	*/
	/* 人員問卷先不作 */

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	declare @subjectKey varchar(6) = null; --'D563'
	select @subjectKey = SubjectKey from v_Group where Id = @groupId
	

	select g.Name as GroupName, mt.Name as GroupTeacherName, r.RoleName
	, x.* from (

		select x.[GroupId], x.[GroupTeacherId], x.[GroupRole], x.PublishNumber
			,sum(QuestionScoreRate * FinalAvg) as AvgScore
			--,sum(QuestionScoreRate * FinalStdev) as StdevScore
			,sum(QuestionScoreRate * FinalStdevp) as StdevpScore
			--, (select count(Number) from Record r where r.Done = 1 and r.PublishNumber = x.PublishNumber and r.GroupId =  x.[GroupId] and r.[GroupTeacherId] = x.[GroupTeacherId] and r.[GroupRole] = x.[GroupRole]) as CompleteCount
			-- 回收份數還是要依照存檔的index查詢
			, (select count(distinct RecordNumber) 
				from RecordScoreIndex rsi
				inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
				inner join Record r on r.Number = rs.RecordNumber
				where rsi.[Guid] = @indexGuid 
					and r.GroupId = x.GroupId
					and r.GroupTeacherId = x.GroupTeacherId
					and r.GroupRole = x.GroupRole
				) as CompleteCount
			, (select count(gm.MemberId) from v_GroupMember gm where gm.GroupId = x.GroupId and gm.RoleCode = x.GroupRole) as PublishCount
		from (
			select x.[GroupId], x.[GroupTeacherId], x.[GroupRole], x.PublishNumber
				, x.QuestionNumber
				, q.Score/100 as QuestionScoreRate
				,AVG(GainAvg) as FinalAvg
				--,AVG(GainStdev) as FinalStdev
				,AVG(GainStdevp) as FinalStdevp
			from (
				select [GroupId], [GroupTeacherId], [GroupRole], PublishNumber
					, ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber
					, AVG(GainScore) as GainAvg 
					--, STDEV(GainScore) as GainStdev 
					, STDEVP(GainScore) as GainStdevp
				from (
					-- 取出最小單位得分
					select r.[GroupId], r.[GroupTeacherId], r.[GroupRole] ,r.PublishNumber 
					,rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber
					, rs.RawScore as GainScore
					from RecordScoreIndex rsi
					inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
					inner join Record r on r.Number = rs.RecordNumber
					--inner join v_Group g on g.Id = r.GroupId
					where r.Done = 1 
					 and rsi.[Guid] = @indexGuid
					 and r.GroupSubjectKey = @subjectKey
					 and rs.RawScore is not null
				) x
				group by [GroupId], [GroupTeacherId], [GroupRole], PublishNumber, ConfigNumber, IndexNumber
				, QuestionNumber, SubsetNumber, GroupingNumber--,QuestionScoreSetting,QuestionItemCount
			) x -- 題組標準差
			inner join QuestionScore q on q.QuestionNumber = x.QuestionNumber and q.ConfigNumber = x.ConfigNumber
			group by x.[GroupId], x.[GroupTeacherId], x.[GroupRole], x.PublishNumber, x.ConfigNumber, x.IndexNumber, x.QuestionNumber
			, q.Score
		) x
		left outer join v_SurveyStatus ss on ss.SurveyNumber = x.PublishNumber
		group by x.[GroupId], x.[GroupTeacherId], x.[GroupRole], PublishNumber

	) x
	inner join v_Group g on g.Id = x.GroupId
	inner join v_Member mt on mt.Id = x.GroupTeacherId
	inner join v_Role r on r.RoleCode = x.GroupRole and r.Category = 'group'

	/*
	declare @subjectKey varchar(6) = null; --'D563'
	select @subjectKey = SubjectKey from v_Group where Id = @groupId

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
				inner join v_Group g on g.Id = r.GroupId
				where rsi.[Guid] = @indexGuid and rs.RawScore is not null
				 and g.SubjectKey = @subjectKey
				-- and r.[GroupId] = isNull(@groupId, [GroupId])
				-- and r.[GroupRole] = isNull(@groupRole, [GroupRole])
				-- and r.[GroupTeacherId] = isNull(@teacherId, [GroupTeacherId])
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
	*/
END

/*


DECLARE @indexGuid uniqueidentifier = '89677108-68e0-4292-918e-697247da6c5b'
,@memberCount int = 0
,@recordCount int = 0
,@subjectKey varchar(6) = 'D580'

exec sp_ScoreReport_GetListByGroupSubject @indexGuid,@memberCount,@recordCount,@subjectKey

select * from v_Group where SubjectKey = @subjectKey
select r.number from v_Group g 
inner join Record r on r.groupid = g.id
where g.SubjectKey = @subjectKey

select rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber
, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber
,rs.QuestionScoreSetting,rs.QuestionItemCount
, sum((rs.RawScore)) as TotalScore
from RecordScoreIndex rsi
inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
inner join Record r on r.Number = rs.RecordNumber
inner join v_Group g on g.Id = r.GroupId
where rsi.[Guid] = @indexGuid and rs.RawScore is not null
and g.SubjectKey = @subjectKey
group by rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber
, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber
,rs.QuestionScoreSetting,rs.QuestionItemCount



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
				inner join v_Group g on g.Id = r.GroupId
				where rsi.[Guid] = @indexGuid and rs.RawScore is not null
				and g.SubjectKey = @subjectKey

				group by rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber,rs.QuestionScoreSetting,rs.QuestionItemCount
			) x
			group by ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber,QuestionScoreSetting,QuestionItemCount
		) x
		group by ConfigNumber, IndexNumber, QuestionNumber, QuestionScoreSetting, QuestionItemCount

	) x
	group by ConfigNumber,IndexNumber




*/