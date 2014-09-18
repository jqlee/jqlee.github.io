-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	查詢某學生應作的教務問卷。(這個方法沒有過濾開放時間)
-- =============================================
CREATE FUNCTION [dbo].[fnGetMatch]
(	
	-- Add the parameters for the function here
	@memberId varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(



	/*
	　在同一個範圍(最小單位)內，不管符合幾次條件都只需要作一次問卷。
	  所以不存TargetNumber
	*/
	select x23.TargetMark,x23.SurveyNumber,x23.MatchKey,x23.MatchFilter,d.Name as MatchName,gl.Name as FilterName from (
		select t.TargetMark,t.SurveyNumber, m.DepartmentId as MatchKey, m.Grade as MatchFilter
		, convert(nvarchar(20),gl.Name) as FilterName
		from v_Member m
		inner join v_Department d on d.Id = m.DepartmentId
		inner join TargetForDepartment t on t.DepartmentId = d.Id and  m.Grade = isNull(t.MemberGrade, m.Grade)
		inner join fnGetGradeList() gl on gl.Value = m.Grade --isNull(t.MemberGrade,gl.Value)
		where m.Id = @memberId and (t.TargetMark = 2 or t.TargetMark = 3)
		group by t.TargetMark,t.SurveyNumber, m.DepartmentId,m.Grade,gl.Name
	) x23
	inner join v_Department d on d.Id = x23.MatchKey
	inner join dbo.fnGetGradeList() gl on gl.Value = x23.MatchFilter

	union all

	--TargetMark == 1,4
	select x14.TargetMark,x14.SurveyNumber,x14.MatchKey,x14.MatchFilter,g.Name as MatchName 
	, convert(varchar(4),g.GroupYear) as FilterName
	from (
		select t.TargetMark,t.SurveyNumber, gm.GroupId as MatchKey, g.GroupYear as MatchFilter
		from v_GroupMember gm
		inner join v_DepartmentGroup g on g.Id = gm.GroupId
		inner join TargetForDepartment t on t.DepartmentId = g.DepartmentId and g.GroupYear = isNull(t.GroupYear, g.GroupYear)
		where gm.MemberId = @memberId and (t.TargetMark = 1 or t.TargetMark = 4)
		group by t.TargetMark,t.SurveyNumber, gm.GroupId,g.GroupYear
	) x14
	inner join v_DepartmentGroup g on g.Id = x14.MatchKey

	
	
	/* 已下是舊的，已確認沒有其它stored procedure用到。為避免view或table function有用到，先保留。
	select s.Number as SurveyNumber, s.Name as SurveyName, s.StartDate, s.EndDate
	, t.Number as TargetNumber, t.TargetMark --, t.Number as TargetNumber 
	 ,m.DepartmentId as [Key] ,m.Grade as Filter, d.Name as Name
	from TargetForDepartment t
	inner join v_Member m  on m.DepartmentId = isNull(t.DepartmentId,m.DepartmentId)
		and  m.Grade = isNull(t.MemberGrade,m.Grade) and m.[Enabled] = 1
	left outer join v_Department d on d.Id = m.DepartmentId
	inner join Survey s on s.Number = t.SurveyNumber
	where m.Id = @memberId and t.TargetMark = 3 and s.[Enabled] = 1 --and s.[EnabledMark] = 1 --and getdate() between s.StartDate and s.EndDate

	union 

	select s.Number as SurveyNumber, s.Name as SurveyName, s.StartDate, s.EndDate
	, t.Number as TargetNumber, t.TargetMark --, t.Number as TargetNumber
	, g.Id as [Key], g.GroupYear as Filter, g.Name as Name
	from TargetForDepartment t
	inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId)
		and g.GroupYear = isNull(t.GroupYear,g.GroupYear)
	inner join v_GroupMember gm on gm.GroupId = g.Id and gm.[Enabled] = 1
	inner join v_Member m on m.Id = gm.MemberId and m.[Enabled] = 1
	inner join Survey s on s.Number = t.SurveyNumber
	--left outer join RecordMatch rm on rm.
	where m.Id = @memberId and t.TargetMark = 4 and s.[Enabled] = 1 --and s.[EnabledMark] = 1 --and getdate() between s.StartDate and s.EndDate
	*/

)
