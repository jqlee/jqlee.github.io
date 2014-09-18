-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyTarget_GetList]
	-- Add the parameters for the stored procedure here
	@surveyNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select 1 as [TargetMark]
	,t.DepartmentId + CONVERT(varchar, t.[Level]) as [TargetTag]
	, t.[Number] as TargetNumber, t.[Name] as TargetName ,x.UserCount from [TargetDepartment] t 
	inner join (
	select t.Number,count(*) as UserCount from [TargetDepartment] t 
	inner join v_Member m on m.DepartmentId = t.DepartmentId and m.[Years] = isNull(t.[Level], m.[Years])
	group by t.Number 
	) x on x.Number = t.Number where t.SurveyNumber = @surveyNumber

	union

	select 2 as [TargetMark]
	,t.GroupId as [TargetTag]
	, t.[Number] as TargetNumber, t.[Name] as TargetName,x.UserCount from [TargetDepartmentGroup] t 
	inner join (
	select t.Number, count(*) as UserCount from [TargetDepartmentGroup] t 
	inner join v_GroupMember gm on gm.GroupId = t.GroupId
	inner join v_Member m on m.Id = gm.MemberId
	group by t.Number
	) x on x.Number = t.Number where t.SurveyNumber = @surveyNumber

	union

	select 3 as [TargetMark]
	,t.MemberId as [TargetTag]
	, t.[Number] as TargetNumber, t.[Name] as TargetName,x.UserCount from [TargetGroupMember] t 
	inner join (
	select t.Number,count(*) as UserCount from [TargetGroupMember] t 
	inner join v_Member m on m.Id = t.MemberId
	group by t.Number
	) x on x.Number = t.Number where t.SurveyNumber = @surveyNumber

	union

	select 4 as [TargetMark]
	,t.DepartmentId+convert(varchar,t.GroupYear) as [TargetTag]
	, t.[Number] as TargetNumber, t.[Name] as TargetName,x.UserCount from [TargetGroupDepartmentByYear] t 
	inner join (
	select t.Number,count(*) as UserCount from [TargetGroupDepartmentByYear] t 
	inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId and g.[Year] = t.GroupYear
	inner join v_GroupMember gm on gm.GroupId = g.Id
	inner join v_Member m on m.Id = gm.MemberId
	group by t.Number
	) x on x.Number = t.Number where t.SurveyNumber = @surveyNumber


END
