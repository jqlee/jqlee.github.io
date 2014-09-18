-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnTargetMatch3]
(	
	-- Add the parameters for the function here
	 @surveyNumber int
)
RETURNS TABLE 
AS
RETURN 
(
	/*
	因為改用階層查詢之後，效能下降非常嚴重，決定還是保留TargetForDepartment到系，另開一表放條件
	*/

	--2 3
	SELECT t.SurveyNumber, t.TargetMark, t.Number as TargetNumber, d.Id as MatchKey, d.Name as MatchName, gl.Value as MatchFilter
		, convert(nvarchar(20),gl.Name) as FilterName
		,count(distinct m.Id) as MemberCount
		,count(distinct r.Number) as RecordCount
	FROM Survey s
		inner join TargetForDepartment t on t.SurveyNumber = s.Number and t.TargetMark = s.TargetMark
		--inner join dbo.fnGetTargetTreeFromSurvey(@surveyNumber) dd on dd.[Enabled] = 1 and dd.DepartmentId = isNull(t.DepartmentId,dd.DepartmentId)
		inner join v_Department d on d.Id = isNull(t.DepartmentId,d.Id)
		--inner join v_Department d on d.Id = dd.DepartmentId
		inner join fnGetGradeList() gl on gl.Value = isNull(t.MemberGrade,gl.Value)
		left outer join v_Member m on m.DepartmentId = t.DepartmentId and m.RoleCode = t.RoleCode and m.Grade = gl.Value and m.[Enabled] =1 and m.BasicRoleValue = 10
		left outer join Record r on r.SurveyNumber = t.SurveyNumber and r.MatchKey = d.Id and r.MatchFilter = m.Grade and r.Done = 1
	where s.Number = @surveyNumber and (s.TargetMark = 2 or s.TargetMark = 3)
	group by t.SurveyNumber, t.TargetMark, t.Number , d.Id, d.Name, gl.Value, gl.Name

	union
	--1 4
	SELECT t.SurveyNumber, t.TargetMark, t.Number as TargetNumber, g.Id as MatchKey, g.Name as MatchName, g.GroupYear as MatchFilter
		,convert(nvarchar(20), g.GroupYear) as FilterName
		,count(distinct gm.MemberId)  as MemberCount
		,count(distinct r.Number)  as RecordCount
	FROM Survey s
		inner join TargetForDepartment t on t.SurveyNumber = s.Number and t.TargetMark = s.TargetMark
		--inner join dbo.fnGetTargetTreeFromSurvey(@surveyNumber) dd on dd.[Enabled] = 1 and dd.DepartmentId = isNull(t.DepartmentId,dd.DepartmentId)
		inner join v_Department d on d.Id = isNull(t.DepartmentId,d.Id)
		--inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId and g.GroupYear = t.GroupYear
		inner join v_DepartmentGroup g on g.DepartmentId = d.Id and g.GroupYear = isNull(t.GroupYear, g.GroupYear)
		left outer join v_GroupMember gm on gm.GroupId = g.Id and gm.GroupRoleValue = 10 and gm.[Enabled] = 1
		left outer join Record r on r.SurveyNumber = t.SurveyNumber and r.MatchKey = g.Id and r.MatchFilter = g.GroupYear and r.Done = 1
	where s.Number = @surveyNumber and (s.TargetMark = 1 or s.TargetMark = 4)
	group by t.SurveyNumber, t.TargetMark, t.Number , g.Id, g.Name, g.GroupYear


	/*
	--2 3
	SELECT t.SurveyNumber, t.TargetMark, t.Number as TargetNumber, d.Id as MatchKey, d.Name as MatchName, gl.Value as MatchFilter
		, convert(nvarchar(20),gl.Name) as FilterName
		,count(distinct m.Id) as MemberCount
		,count(distinct r.Number) as RecordCount
	FROM Survey s
		inner join TargetForDepartment t on t.SurveyNumber = s.Number and t.TargetMark = s.TargetMark
		inner join dbo.fnGetTargetTreeFromSurvey(@surveyNumber) dd on dd.[Enabled] = 1
		--inner join v_Department d on d.Id = t.DepartmentId
		inner join v_Department d on d.Id = dd.DepartmentId
		inner join fnGetGradeList() gl on gl.Value = isNull(t.MemberGrade,gl.Value)
		left outer join v_Member m on m.DepartmentId = t.DepartmentId and m.RoleCode = t.RoleCode and m.Grade = gl.Value and m.[Enabled] =1 and m.BasicRoleValue = 10
		left outer join Record r on r.SurveyNumber = t.SurveyNumber and r.MatchKey = d.Id and r.MatchFilter = m.Grade and r.Done = 1
	where s.Number = @surveyNumber and (s.TargetMark = 2 or s.TargetMark = 3)
	group by t.SurveyNumber, t.TargetMark, t.Number , d.Id, d.Name, gl.Value, gl.Name

	union
	--1 4
	SELECT t.SurveyNumber, t.TargetMark, t.Number as TargetNumber, g.Id as MatchKey, g.Name as MatchName, g.GroupYear as MatchFilter
		,convert(nvarchar(20), g.GroupYear) as FilterName
		,count(distinct gm.MemberId)  as MemberCount
		,count(distinct r.Number)  as RecordCount
	FROM Survey s
		inner join TargetForDepartment t on t.SurveyNumber = s.Number and t.TargetMark = s.TargetMark
		inner join dbo.fnGetTargetTreeFromSurvey(@surveyNumber) dd on dd.[Enabled] = 1
		--inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId and g.GroupYear = t.GroupYear
		inner join v_DepartmentGroup g on g.DepartmentId = dd.DepartmentId and g.GroupYear = isNull(t.GroupYear, g.GroupYear)
		left outer join v_GroupMember gm on gm.GroupId = g.Id and gm.GroupRoleValue = 10 and gm.[Enabled] = 1
		left outer join Record r on r.SurveyNumber = t.SurveyNumber and r.MatchKey = g.Id and r.MatchFilter = g.GroupYear and r.Done = 1
	where s.Number = @surveyNumber and (s.TargetMark = 1 or s.TargetMark = 4)
	group by t.SurveyNumber, t.TargetMark, t.Number , g.Id, g.Name, g.GroupYear
	*/
)
