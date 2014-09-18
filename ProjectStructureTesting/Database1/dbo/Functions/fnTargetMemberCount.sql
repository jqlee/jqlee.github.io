﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	為保持人員名單依照狀態變更與修課調整同步，以此函式計算條件人數
--              人數根據target設定的條件對應而來，而target則存入資料庫，若有調整(課程年份、課程系所、課程狀態)須手動重整
-- =============================================
CREATE FUNCTION [dbo].[fnTargetMemberCount]
(	
	-- Add the parameters for the function here
	@surveyNumber int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here


	select t.Number AS [TargetNumber]--,t.MatchKey
	,count(0) as MemberCount 
	,count(RecordNumber) as StartCount 
	,sum( case when RecordDone = 1 then 1 else 0 end) as RecordCount 
	from [Target] t 
	inner join fnTargetMatch(@surveyNumber) tm  on t.MatchKey = tm.MatchKey
	where t.[SurveyNumber] = @surveyNumber
	group by t.Number--,t.MatchKey
	/*

	select TargetNumber,isNull(count(MemberId),0) as MemberCount from (
		select distinct t.Number as TargetNumber,tc.Number as ConditionNumber, m.Id as MemberId,m.DepartmentId,m.Grade as MemberGrade,m.RoleCode
		from [Condition] tc
		inner join [Target] t on t.ConditionNumber = tc.Number
		left outer join v_Member m on m.DepartmentId = t.DepartmentId and m.Grade = t.MemberGrade and m.RoleCode = t.RoleCode and m.[Enabled] = 1
		where tc.Number = @conditionNumber and (tc.TargetMark = 2 or tc.TargetMark = 3)
	) x
	group by TargetNumber

	union 

	select TargetNumber,isNull(count(MemberId),0) as MemberCount from (
		select distinct t.Number as TargetNumber, tc.Number as ConditionNumber, m.Id as MemberId,m.DepartmentId,m.RoleCode
		from [Condition] tc
		inner join [Target] t on t.ConditionNumber = tc.Number
		--inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId and g.GroupYear = isNull(t.GroupYear,g.GroupYear)
		left outer join v_GroupMember gm on gm.GroupId = t.GroupId and gm.[Enabled] = 1
		left outer join v_Member m on m.Id = gm.MemberId and m.RoleCode = t.RoleCode and m.[Enabled] = 1
		where tc.Number = @conditionNumber and (tc.TargetMark = 1 or tc.TargetMark = 4)
	) x
	group by TargetNumber
	*/
)
