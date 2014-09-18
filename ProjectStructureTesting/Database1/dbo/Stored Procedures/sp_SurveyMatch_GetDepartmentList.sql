-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SurveyMatch_GetDepartmentList
	-- Add the parameters for the stored procedure here
	@memberId varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		-- Insert statements for procedure here
	select s.Name as SurveyName, t.SurveyNumber, t.TargetMark, t.Number as TargetNumber 
	 ,m.DepartmentId as MatchKey ,m.Grade as MatchOption, d.Name as MatchName
	from TargetForDepartment t
	inner join v_Member m  on m.DepartmentId = isNull(t.DepartmentId,m.DepartmentId)
		and  m.Grade = isNull(t.MemberGrade,m.Grade) and m.[Enabled] = 1
	left outer join v_Department d on d.Id = m.DepartmentId
	inner join Survey s on s.Number = t.SurveyNumber
	where m.Id = @memberId and t.TargetMark = 3

	union 

	select s.Name as SurveyName, t.SurveyNumber, t.TargetMark, t.Number as TargetNumber
	, g.Id as MatchKey, g.GroupYear as MatchOption, g.Name as MatchName
	from TargetForDepartment t
	inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId)
		and g.GroupYear = isNull(t.GroupYear,g.GroupYear)
	inner join v_GroupMember gm on gm.GroupId = g.Id and gm.[Enabled] = 1
	inner join v_Member m on m.Id = gm.MemberId and m.[Enabled] = 1
	inner join Survey s on s.Number = t.SurveyNumber
	where m.Id = @memberId and t.TargetMark = 4
END
