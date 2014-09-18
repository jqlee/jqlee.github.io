
CREATE PROCEDURE [dbo].[sp_TargetForGroup_GetMatch]
	@surveyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	
	select t.Number,t.SurveyNumber,t.TargetMark
	, m.DepartmentId, m.DepartmentName
	, g.Id as GroupId, g.Name as GroupName
	, m.Id as MemberId, m.Name as MemberName
	from TargetForGroup t
		inner join v_GroupMember gm on gm.GroupId = t.GroupId and gm.MemberId = isNull(t.MemberId,gm.MemberId)
		inner join v_Member m on m.Id = gm.MemberId
	left outer join v_DepartmentGroup g on g.Id = t.GroupId
	where t.SurveyNumber = @surveyNumber
	order by TargetMark
END



