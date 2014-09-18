
CREATE PROCEDURE [dbo].[sp_RecordTarget_CreateEmptyByIndex]
	@indexNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;

	delete from RecordTarget where IndexNumber = @indexNumber;
/*
	Insert into RecordTarget ([PublishNumber],[IndexNumber]
	,[GroupId],[GroupTeacherId],[GroupRole],[GroupRoleName],[GroupName],[GroupTeacherName]
	,[GroupDepartmentName],[GroupDepartmentId]
	,[GroupSubjectKey],[GroupGrade],[GroupGrp],[GroupSubgrp]
	,[CompleteCount],[PublishCount],[CompleteRate],[FinalScore],[StdevpScore])
*/
	select x.PublishNumber, @indexNumber as IndexNumber, x.GroupId, x.GroupTeacherId, x.GroupRole, r.RoleName as GroupRoleName
	, g.Name as GroupName, mt.Name as GroupTeacherName
	, d.Name as GroupDepartmentName, g.DepartmentId as GroupDepartmentId
	, g.SubjectKey as GroupSubjectKey, g.Grade as GroupGrade, g.Grp as GroupGrp, g.Subgrp as GroupSubgrp
	, x.CompleteCount, x.PublishCount, (Convert(float,x.CompleteCount)/x.PublishCount) as [CompleteRate], x.FinalScore, x.StdevpScore
	
	from (
		select x.[GroupId], x.[GroupTeacherId], x.[GroupRole], x.PublishNumber
			,sum(QuestionScoreRate * FinalAvg) as FinalScore
			,sum(QuestionScoreRate * FinalStdevp) as StdevpScore

			--, (select count(Number) from Record r where r.Done = 1 and r.PublishNumber = x.PublishNumber and r.GroupId =  x.[GroupId] and r.[GroupTeacherId] = x.[GroupTeacherId] and r.[GroupRole] = x.[GroupRole]) as CompleteCount
			-- 回收份數還是要依照存檔的index查詢
			, (select count(distinct RecordNumber) 
				from RecordScoreIndex rsi
				inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
				inner join Record r on r.Number = rs.RecordNumber
				where rsi.[Number] = @indexNumber 
					and r.GroupId = x.GroupId
					and r.GroupTeacherId = x.GroupTeacherId
					and r.GroupRole = x.GroupRole
				) as CompleteCount
			, (select count(gm.MemberId) from v_GroupMember gm where gm.GroupId = x.GroupId and gm.RoleCode = x.GroupRole) as PublishCount
			--, (select count(gm.MemberId) from v_GroupMember gm where gm.GroupId = x.GroupId and gm.RoleCode = x.GroupRole) as PublishCount
		from (
			select x.[GroupId], x.[GroupTeacherId], x.[GroupRole], x.PublishNumber
				, x.QuestionNumber
				, q.Score/100 as QuestionScoreRate
				,AVG(GainAvg) as FinalAvg
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
					where rsi.[Number] = @indexNumber --rsi.[Guid] = @indexGuid
						--and r.Done = 1 -- 存檔時已經篩選過
					-- and r.GroupSubjectKey = @subjectKey
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

		union 

		select [GroupId], [GroupTeacherId], [GroupRole], x.PublishNumber
			,0 as FinalScore
			,0 as StdevpScore
			,CompleteCount
			,PublishCount
			--, (select count(gm.MemberId) from v_GroupMember gm where gm.GroupId = x.GroupId and gm.RoleCode = x.GroupRole) as PublishCount

		from (
			select sm.[GroupId],sm.TeacherId as [GroupTeacherId], sm.GroupRole, sc.PublishNumber
			,sum(Convert(int,isNull(sm.RecordDone,0))) as CompleteCount, count(sm.MemberId) as PublishCount
			from RecordScoreIndex rsi 
			inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
			inner join v_SurveyMatch sm on sm.SurveyNumber =  sc.PublishNumber
			--left outer join Record r on r.PublishNumber = sc.PublishNumber and r.MemberId = sm.MemberId
			where rsi.Number = @indexNumber --and sm.RecordNumber is null and (sm.RecordDone is null or sm.RecordDone = 0)
			group by sm.[GroupId],sm.TeacherId, sm.GroupRole, sc.PublishNumber
		) x 
		where CompleteCount = 0
	) x
	inner join v_Group g on g.Id = x.GroupId
	inner join v_Department d on d.Id = g.DepartmentId
	inner join v_Member mt on mt.Id = x.GroupTeacherId
	inner join v_Role r on r.RoleCode = x.GroupRole and r.Category = 'group'

END

/*
declare @indexNumber int = 130
exec sp_RecordTarget_CreateEmptyByIndex @indexNumber
*/