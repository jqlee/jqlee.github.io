-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetMatchCountByCondition]
(	
	-- Add the parameters for the function here
	@conditionNumber int = null
)
RETURNS TABLE 
AS

RETURN 
(

/*
檢查當前符合資格的學生
1. 教務設定時查數量要加上man_mark=='10',manscore_mark=='10'等判斷
2. 學生登入時判斷應作問卷，登入後已驗證人員身分，只需要判斷修課身分manscore_mark=='10'
3. 之後填答紀錄時不需要判斷這些
-- and t.SurveyNumber = isNull(@surveyNumber, t.SurveyNumber) 

*/


	select t.Number as TargetNumber
	,count(distinct m.DepartmentId) as DepartmentCount
	, 0 as GroupCount
	, count(distinct m.DepartmentId+'__'+convert(char,m.Grade)) as ItemCount
	, count(m.Id) as MemberCount
	, count(rm.Number) as RecordCount
	from TargetForDepartment t
/*	
	inner join fnGetTargetTreeFromSurvey(@surveyNumber) tt on tt.[Enabled] = 1 
		and ( tt.DepartmentId=isNull(t.DepartmentId,tt.DepartmentId) or tt.ParentId=isNull(t.DepartmentId, tt.ParentId) )
*/
	left outer join v_Member m on m.DepartmentId = t.DepartmentId and m.RoleCode = t.RoleCode
		and isNull(m.Grade,'') = isNull(t.[MemberGrade], isNull(m.Grade,'')) and m.[Enabled] = 1 --and m.[BasicRoleValue] = 10
	left outer join RecordMatch rm on rm.SurveyNumber = t.SurveyNumber 
		and rm.[key] = t.DepartmentId and rm.[Filter] = isNull(t.MemberGrade, rm.[Filter])
	where t.ConditionNumber = @conditionNumber and (t.TargetMark = 2 or t.TargetMark = 3)
	group by t.Number

union

	select t.Number as TargetNumber
		,count(distinct g.DepartmentId)  as DepartmentCount
		,count(distinct g.Id) as GroupCount
		, count(distinct g.Id) as ItemCount
		, count(m.Id) as MemberCount 
		, count(rm.Number) as RecordCount
	from TargetForDepartment t
	/*
	inner join fnGetTargetTreeFromSurvey(@surveyNumber) tt on tt.[Enabled] = 1 and ( tt.DepartmentId=isNull(t.DepartmentId,tt.DepartmentId) or tt.ParentId=isNull(t.DepartmentId, tt.ParentId) )
	*/
	inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId
		and g.GroupYear = isNull(t.[GroupYear], g.GroupYear)

--	inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId) and g.GroupYear = isNull(t.[GroupYear], g.GroupYear)
	left outer join v_GroupMember gm on gm.GroupId = g.Id and gm.[Enabled] = 1 --and gm.GroupRoleValue=10
	left outer join v_Member m on m.Id = gm.MemberId and m.RoleCode = t.RoleCode
		and m.[Enabled] = 1 --and m.[BasicRoleValue] = 10
	left outer join RecordMatch rm on rm.SurveyNumber = t.SurveyNumber and rm.[key] = t.DepartmentId and rm.[Filter] = t.MemberGrade
	where t.ConditionNumber = @conditionNumber and(t.TargetMark = 1 or t.TargetMark = 4) and gm.MemberId is not null and gm.[Enabled] = 1
	group by  t.Number

)
