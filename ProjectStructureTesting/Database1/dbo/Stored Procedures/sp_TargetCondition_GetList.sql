
CREATE PROCEDURE [dbo].[sp_TargetCondition_GetList]
	@surveyNumber int = null


AS
BEGIN
	--基本上條件清單就是單純取回condition表的資料，
	--除了人數部分採用與target對應項目join之後的累計，以表現即時的更動
	--但對應項目須手動重整，重整時機在html/ReadMe_refreshTarget.htm內

	SET NOCOUNT ON;
	SELECT --d.Name as [Name], 
	r.RoleName, tc.*
	, (select count(*) from [TargetForDepartment] where [ConditionNumber] = tc.[Number]) as [TargetCount]
	, isNull(cmc.MemberCount,0) as TotalMemberCount
	FROM [dbo].[TargetCondition] tc 
	--left outer join v_Department d on d.Id = tc.DepartmentId
	left outer join v_Role r on r.RoleCode = tc.RoleCode
	left outer join fnConditionMemberCount(@surveyNumber) cmc on cmc.ConditionNumber = tc.Number
	where tc.[SurveyNumber] = isNull(@surveyNumber,tc.[SurveyNumber])
	
END
