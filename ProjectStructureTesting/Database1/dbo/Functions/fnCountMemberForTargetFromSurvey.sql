﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	為保持人員名單依照狀態變更與修課調整同步，以此函式計算條件人數
--              人數根據target設定的條件對應而來，而target則存入資料庫，若有調整(課程年份、課程系所、課程狀態)須手動重整
-- =============================================
CREATE FUNCTION [dbo].[fnCountMemberForTargetFromSurvey]
(	
	-- Add the parameters for the function here
	@surveyNumber int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select TargetNumber,isNull(count(*),0) as MemberCount from (
		select distinct t.Number as TargetNumber, m.Id as MemberId,m.DepartmentId,m.Grade as MemberGrade,m.RoleCode
		from [Survey] s
		inner join [Condition] tc on tc.SurveyNumber = s.Number and tc.TargetMark = s.TargetMark
		inner join [Target] t on t.ConditionNumber = tc.Number
		left outer join v_Member m on m.DepartmentId = t.DepartmentId and m.Grade = t.MemberGrade and m.RoleCode = t.RoleCode and m.[Enabled] = 1
		where s.Number = @surveyNumber --tc.Number = @conditionNumber
	) x
	group by TargetNumber

	union 

	select TargetNumber,isNull(count(*),0) as MemberCount from (
		select distinct t.Number as TargetNumber, m.Id as MemberId,m.DepartmentId,g.GroupYear,m.RoleCode
		from [Survey] s
		inner join [Condition] tc on tc.SurveyNumber = s.Number and tc.TargetMark = s.TargetMark
		inner join [Target] t on t.ConditionNumber = tc.Number
		inner join v_DepartmentGroup g on g.Id = t.GroupId --因為groupId不會重複，沒有必要再檢查 departmentId 與 groupYear
		left outer join v_GroupMember gm on gm.GroupId = g.Id and gm.[Enabled] = 1 and gm.RoleCode = t.RoleCode
		left outer join v_Member m on m.Id = gm.MemberId and m.[Enabled] = 1
		where s.Number = @surveyNumber -- tc.Number = @conditionNumber
	) x
	group by TargetNumber

)

