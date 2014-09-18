-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyTarget_GetListForDepartment]
	-- Add the parameters for the stored procedure here
	@surveyNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
	select t.*, d.Name, 0 as GroupCount,m.MemberCount 
	from TargetForDepartment t
	inner join (
		select t.Number, count(m.Id) as MemberCount from TargetForDepartment t
		inner join v_Member m on m.DepartmentId = t.DepartmentId and m.Years = isNull(t.[MemberGrade], m.Years)
		where t.SurveyNumber = @surveyNumber and t.TargetMark = 3
		group by t.Number -- m.DepartmentId
	) as m on m.Number = t.Number
	left outer join v_Department d on d.Id = t.DepartmentId
	where t.SurveyNumber = @surveyNumber
	union
	select t.*, d.Name , m.GroupCount,m.MemberCount 
	from TargetForDepartment t
	inner join (
		select x.Number, count(GroupId) as GroupCount, sum(MemberCount) as MemberCount from (
			select t.Number, g.Id as GroupId, count(m.Id) as MemberCount from TargetForDepartment t
			inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId and g.GroupYear = isNull(t.[GroupYear], g.GroupYear)
			inner join v_GroupMember gm on gm.GroupId = g.Id
			inner join v_Member m on m.Id = gm.MemberId
			where t.SurveyNumber = @surveyNumber and t.TargetMark = 4
			group by t.Number, g.Id
		) x group by x.Number
	) as m on m.Number = t.Number
	left outer join v_Department d on d.Id = t.DepartmentId
	where t.SurveyNumber = @surveyNumber



END
