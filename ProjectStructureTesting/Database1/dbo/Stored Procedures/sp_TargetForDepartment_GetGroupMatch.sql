
CREATE PROCEDURE [dbo].[sp_TargetForDepartment_GetGroupMatch]
	@surveyNumber int = 0
	,@departmentFilter varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	select t.Number,t.SurveyNumber,t.DepartmentId, d.Name as DepartmentName, t.GroupYear, m.GroupId, g.Name as GroupName,m.MemberCount 
	from TargetForDepartment t
	inner join (
		select t.Number, g.Id as GroupId, count(m.Id) as MemberCount from TargetForDepartment t
		inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId) and g.GroupYear = isNull(t.[GroupYear], g.GroupYear)
		inner join v_GroupMember gm on gm.GroupId = g.Id
		inner join v_Member m on m.Id = gm.MemberId and m.[Grade] = isNull(t.MemberGrade,m.[Grade])
		where t.SurveyNumber = @surveyNumber and t.TargetMark = 4
		group by t.Number, g.Id
	) as m on m.Number = t.Number
	left outer join v_Department d on d.Id = isNull(t.DepartmentId,d.Id)
	left outer join v_Group g on g.Id = m.GroupId
	where t.SurveyNumber = @surveyNumber and t.DepartmentId = isNull(@departmentFilter,t.DepartmentId)

END
