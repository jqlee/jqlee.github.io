
CREATE PROCEDURE [dbo].[sp_TargetForGroup_GetList]
	@surveyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	
	select t.Number,t.SurveyNumber, t.GroupId, t.MemberId,t.TargetMark
	,case t.TargetMark 
		when 1 then g.Name
		when 2 then m.Id+' '+m.Name
	else '' end as Name
	,g.Name as GroupName
	,m.Name as MemberName
	from TargetForGroup t
	inner join v_DepartmentGroup g on g.Id = t.GroupId
	left outer join v_Member m on m.Id = t.MemberId
	where t.SurveyNumber = @surveyNumber
	order by TargetMark
END


