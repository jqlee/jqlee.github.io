
CREATE PROCEDURE [dbo].[del_sp_CourseStudent_GetRandomList]
AS
BEGIN
	SET NOCOUNT ON;

	
	select [StudentId],[CourseId],[IsAudit] from (
		select top 10 '10' as Mark, t.SurveyNumber,s.Id as [StudentId], null as [CourseId], Convert(bit,0) as [IsAudit]
		FROM [dbo].[v_Member] s
			inner join [TargetDepartment] t on t.DepartmentId = s.DepartmentId and t.[Level] = s.[Level]
		union all
		select top 10 '20' as Mark, t.SurveyNumber,cs.MemberId as [StudentId], cs.GroupId as [CourseId], cs.[IsAudit] 
		FROM [dbo].[v_GroupMember] cs
			inner join [TargetDepartmentGroup] t on t.GroupId = cs.GroupId
		union all
		select top 10 '30' as Mark, t.SurveyNumber,cs.MemberId as [StudentId], cs.GroupId as [CourseId], cs.[IsAudit]
		FROM [dbo].[v_GroupMember] cs
			inner join [TargetGroupMember] t on t.GroupId = cs.GroupId and t.MemberId = cs.MemberId
		union all
		select top 10 '40' as Mark, t.SurveyNumber, cs.MemberId as [StudentId], cs.GroupId as [CourseId], cs.[IsAudit] 
		FROM [dbo].[v_GroupMember] cs
			inner join v_DepartmentGroup c on c.Id = cs.GroupId
			inner join [TargetGroupDepartmentByYear] t on t.DepartmentId = c.DepartmentId
	) x order by newid()

END

