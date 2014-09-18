-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyUser_GetList]
	@surveyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT x.*, r.Number as [RecordNumber] FROM (
		select 1 as [TargetMark], t.Number as TargetNumber, t.SurveyNumber--, t.DepartmentId
		,m.Id ,m.Name , d.Name as [DepartmentName]
		,t.DepartmentId + CONVERT(varchar, t.[Level]) as [TargetTag]
		, d.id+ d.[Name] as [TargetName]
		from TargetDepartment t
		inner join v_Member m on m.DepartmentId = t.DepartmentId and m.[Grade] = isNull(t.[Level], m.[Grade])
		inner join v_Department d on d.Id = t.DepartmentId
		where t.SurveyNumber = @surveyNumber
		union
		select 2 as [TargetMark], t.Number as TargetNumber, t.SurveyNumber--, gm.GroupId
		,m.Id ,m.Name , d.Name as [DepartmentName]
		,t.GroupId as [TargetTag] , g.Id+ g.[Name] as [TargetName]
		from TargetDepartmentGroup t 
		inner join v_GroupMember gm on gm.GroupId = t.GroupId
		inner join v_DepartmentGroup g on g.Id = t.GroupId
		inner join v_Member m on m.Id = gm.MemberId
		inner join v_Department d on d.Id = m.DepartmentId
		where t.SurveyNumber = @surveyNumber
		union
		select 3 as [TargetMark], t.Number as TargetNumber, t.SurveyNumber
		,m.Id , m.Name  , d.Name as [DepartmentName]
		,t.MemberId as [TargetTag], g.id+g.[Name] as [TargetName]
		from TargetGroupMember t
		inner join v_Member m on m.Id = t.MemberId
		inner join v_DepartmentGroup g on g.Id = t.GroupId
		inner join v_Department d on d.Id = m.DepartmentId
		where t.SurveyNumber = @surveyNumber
		union
		select 4 as [TargetMark], t.Number as TargetNumber, t.SurveyNumber
		,m.Id , m.Name , d.Name as [DepartmentName]
		,t.DepartmentId+convert(varchar,t.GroupYear) as [TargetTag], g.Id+ d.Name+ g.[Year]+ g.Name as [TargetName]
		from TargetGroupDepartmentByYear t 
		inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId and g.[Year]=t.[GroupYear]
		inner join v_Department d on d.Id = g.DepartmentId
		inner join v_GroupMember gm on gm.GroupId = g.Id
		inner join v_Member m on m.Id = gm.MemberId
		where t.SurveyNumber = @surveyNumber
	) x

	left outer join Record r on r.SurveyNumber = x.SurveyNumber and r.MemberId = x.Id

	order by x.Id, x.Name
END
