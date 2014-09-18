-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TargetMatchDepartment_GetList]
	-- Add the parameters for the stored procedure here
	@targetNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select t.TargetMark,t.DepartmentId as TargetDepartment
		,x.*
		, d.Name as DepartmentName 
	 from TargetForDepartment t 
	inner join (
		select t.Number as TargetNumber, tm.MatchItem, tm.MatchName
			,count(tm.MemberId) as MemberCount 
			,count(tm.RecordNumber) as RecordCount 
		from TargetForDepartment t
		inner join v_TargetMember tm on tm.TargetNumber = t.Number
		where t.Number = @targetNumber 
		group by t.Number, tm.MatchItem,tm.MatchName
	) x on x.TargetNumber = t.Number
	inner join v_Department d on d.Id = t.DepartmentId
/*
select isNull(d.Name,'[Unknown]') as DepartmentName, null as GroupName, x.*
from (
	select t.TargetMark, t.Number as TargetNumber,m.DepartmentId as TargetDepartment
	,m.Grade as TargetGrade
	,null as TargetGroup, null as TargetYear
	, count(m.Id) as MemberCount 
	, count(rm.Number) as RecordCount
	from TargetForDepartment t
	inner join v_Member m on m.DepartmentId = isNull(t.DepartmentId,m.DepartmentId)
		and m.Grade = isNull(t.[MemberGrade], m.Grade)
	left outer join RecordMatch rm on rm.SurveyNumber = t.SurveyNumber and rm.[key] = isNull(t.DepartmentId, rm.[key] ) and rm.[Filter] = isNull(t.MemberGrade, rm.[Filter])
	where t.Number = @targetNumber and t.TargetMark = 3 and m.[Enabled] = 1 and m.BasicRoleValue = 10
	group by t.TargetMark, t.Number,m.DepartmentId,m.Grade -- m.DepartmentId
) x
left outer join v_Department d on d.Id = isNull(x.TargetDepartment,d.Id)

union

select null as DepartmentName, isNull(g.Name,'[Unknown]') as GroupName, x.*
from (
	select t.TargetMark, t.Number as TargetNumber
		--, d.Id as TargetDepartment
		,g.DepartmentId  as TargetDepartment
		,null as TargetGrade
		,g.Id as TargetGroup
		,g.GroupYear as TargetYear
		, count(gm.MemberId)as MemberCount 
		, count(rm.Number) as RecordCount
		--, sum(case when gm.MemberId is Null then 0 else 1 end) as MemberCount 
	from TargetForDepartment t
	--inner join v_Department d on d.Id = isNull(t.DepartmentId, d.Id)
	inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId) and g.GroupYear = isNull(t.[GroupYear], g.GroupYear)
	left join v_GroupMember gm on gm.GroupId = g.Id and gm.GroupRoleValue=10
	--inner join v_Member m on m.Id = gm.MemberId
	left outer join RecordMatch rm on rm.SurveyNumber = t.SurveyNumber and rm.[key] = t.DepartmentId and rm.[Filter] = t.MemberGrade
	where t.Number = @targetNumber and t.TargetMark = 4 and gm.MemberId is not null and gm.[Enabled] = 1
	group by t.TargetMark, t.Number
	--, d.Id
	,g.DepartmentId 
	, g.Id, g.GroupYear
) x
left outer join v_DepartmentGroup g on g.Id = isNull(x.TargetGroup,g.Id)

*/

END

