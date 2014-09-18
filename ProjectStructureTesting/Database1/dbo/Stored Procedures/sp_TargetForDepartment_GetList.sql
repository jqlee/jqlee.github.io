
CREATE PROCEDURE [dbo].[sp_TargetForDepartment_GetList]
	--@surveyNumber int = null
	--,
	@conditionNumber int = null
AS
BEGIN
	SET NOCOUNT ON;

	select t.*, d.Name as DepartmentName
	,isNull(tm.MatchCount,0) as MatchCount
	,isNull(tm.MemberCount,0) as MemberCount
	from TargetForDepartment t 
	left outer join (
		select TargetNumber,count(distinct MatchItem) as MatchCount,count(distinct MemberId) as MemberCount 
		from v_TargetMember group by TargetNumber
	) tm on tm.TargetNumber = t.Number
	inner join v_Department d on d.Id = t.DepartmentId
	where t.ConditionNumber = @conditionNumber

return;

	--即時計算修課人數，但不反應系統年級參數變化、院系項目調整以及課程年份的變動，以上變動須手動重整
	/*
select t.*, tmc.DepartmentCount, tmc.ItemCount,tmc.GroupCount,tmc.MemberCount
,d.Name as DepartmentName
,s.[Guid] as SurveyId
,vr.RoleName
from Survey s 
inner join TargetForDepartment t on t.SurveyNumber = s.Number
left outer join v_Role vr on vr.RoleCode = t.RoleCode
left outer join dbo.fnGetMatchCountBySurvey(@surveyNumber) tmc on tmc.TargetNumber = t.Number
left outer join v_Department d on d.Id = t.DepartmentId
where s.Number = @surveyNumber and t.ConditionNumber = isNull(@conditionNumber,t.ConditionNumber)
order by t.DepartmentId, t.GroupYear, t.MemberGrade
*/
	/*
	select t.Number,t.SurveyNumber,t.DepartmentId,t.MemberGrade,t.GroupYear,t.TargetMark
	, d.Name as Name, d.Name as DepartmentName
	from TargetForDepartment t
	left outer join v_Department d on d.Id = t.DepartmentId
	where t.SurveyNumber = @surveyNumber
	order by TargetMark
	*/
END