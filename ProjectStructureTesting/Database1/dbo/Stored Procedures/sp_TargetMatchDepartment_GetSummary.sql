-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TargetMatchDepartment_GetSummary]
	-- Add the parameters for the stored procedure here
	@targetNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	/*
	
	return TargetNumber,DepartmentCount,GroupCount,MemberCount,RecordCount
	*/



	select t.Number as TargetNumber
	,count(distinct m.DepartmentId) as DepartmentCount
	, 0 as GroupCount
	, count(m.Id) as MemberCount
	, count(rm.Number) as RecordCount
	from TargetForDepartment t
	inner join v_Member m on m.DepartmentId = isNull(t.DepartmentId,m.DepartmentId)
		and m.Grade = isNull(t.[MemberGrade], m.Grade)
	left outer join RecordMatch rm on rm.SurveyNumber = t.SurveyNumber and rm.[key] = isNull(t.DepartmentId, rm.[key] ) and rm.[Filter] = isNull(t.MemberGrade, rm.[Filter])
	where t.Number = @targetNumber and t.TargetMark = 3
	group by t.Number -- m.DepartmentId

union

	select t.Number as TargetNumber
		,count(distinct g.DepartmentId)  as DepartmentCount
		,0 as GroupCount
		, count(gm.MemberId) as MemberCount 
		, count(rm.Number) as RecordCount
	from TargetForDepartment t
	inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId) and g.GroupYear = isNull(t.[GroupYear], g.GroupYear)
	left outer join v_GroupMember gm on gm.GroupId = g.Id and gm.GroupRoleValue=10
	left outer join RecordMatch rm on rm.SurveyNumber = t.SurveyNumber and rm.[key] = t.DepartmentId and rm.[Filter] = t.MemberGrade
	where t.Number = @targetNumber and t.TargetMark = 4 and gm.MemberId is not null and gm.[Enabled] = 1
	group by  t.Number


END
