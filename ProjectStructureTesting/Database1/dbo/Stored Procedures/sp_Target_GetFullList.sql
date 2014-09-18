
CREATE PROCEDURE [dbo].[sp_Target_GetFullList]
	@surveyNumber int = 0
	,@conditionNumber int = 0

AS
BEGIN
	SET NOCOUNT ON;

	if (@conditionNumber = 0) set @conditionNumber = null;

	SELECT t.* --[Number], [ConditionNumber],/* [TargetMark],*/ [DepartmentId], [MatchKey], [MatchName], [RoleCode]
	, isNull(tmc.MemberCount,0) as MemberCount
	, isNull(tmc.RecordCount,0) as RecordCount
	FROM 
	[ConditionTarget] c 
	inner join [dbo].[Target] t on t.Number = c.TargetNumber
	--left outer join fnTargetMemberCount(@conditionNumber) tmc on tmc.TargetNumber = t.Number
	left outer join fnSurveyMemberCount(@surveyNumber) tmc on tmc.TargetNumber = t.Number
	
	where t.SurveyNumber = @surveyNumber and c.ConditionNumber = isNull(@conditionNumber,c.ConditionNumber)

END