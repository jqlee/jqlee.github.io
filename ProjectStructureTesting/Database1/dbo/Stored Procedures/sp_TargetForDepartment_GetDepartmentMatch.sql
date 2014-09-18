
CREATE PROCEDURE [dbo].[sp_TargetForDepartment_GetDepartmentMatch]
	@surveyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;

	select t.*, d.Name as Name, d.Name as DepartmentName, 0 as GroupCount
		, m.MemberCount
	--,isNull(m.MemberCount,0) as MemberCount
	from TargetForDepartment t
	left outer join v_Department d on d.Id = isNull(t.DepartmentId,d.Id)
	inner join (
		select t.Number,m.DepartmentId, count(m.Id) as MemberCount from TargetForDepartment t
		inner join v_Member m on m.DepartmentId = isNull(t.DepartmentId,m.DepartmentId)
			and m.Grade = isNull(t.[MemberGrade], m.Grade)
		where t.SurveyNumber = @surveyNumber and t.TargetMark = 3
		group by t.Number,m.DepartmentId -- m.DepartmentId
	) as m on m.Number = t.Number and m.DepartmentId = d.Id
	where t.SurveyNumber = @surveyNumber


	union


	select t.*, d.Name as Name, d.Name as DepartmentName 
		, isNull(m.GroupCount,0) as GroupCount
		, isNull(m.MemberCount,0) as MemberCount
	from TargetForDepartment t
	left outer join (
		select x.Number
			, sum(DepartmentCount) as DepartmentCount
			, sum(GroupCount) as GroupCount
			, sum(MemberCount) as MemberCount from (
			select t.Number
				, count(distinct d.Id) as DepartmentCount
				, Count(distinct g.Id) as GroupCount
				, sum(case when gm.MemberId is Null then 0 else 1 end) as MemberCount 
			from TargetForDepartment t
			inner join v_Department d on d.Id = isNull(t.DepartmentId, d.Id)
			inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId) and g.GroupYear = isNull(t.[GroupYear], g.GroupYear)
			inner join v_GroupMember gm on gm.GroupId = g.Id
			inner join v_Member m on m.Id = gm.MemberId --and m.Grade = isNull(t.MemberGrade,m.Grade)
			where t.SurveyNumber = @surveyNumber and t.TargetMark = 4 and gm.MemberId is not null and gm.[Enabled] = 1
			group by t.Number, d.Id, g.Id
		) x group by x.Number
	) as m on m.Number = t.Number 
	left outer join v_Department d on d.Id = isNull(t.DepartmentId,d.Id) 

	where t.SurveyNumber = @surveyNumber
	order by t.TargetMark

END
