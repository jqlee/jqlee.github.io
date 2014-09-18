
CREATE PROCEDURE [dbo].[sp_Target_GetList]
	@conditionNumber int = null

AS
BEGIN
	SET NOCOUNT ON;
	
	declare @surveyNumber int
	select @surveyNumber = [SurveyNumber] from [Condition] where Number = @conditionNumber
	
	SELECT t.* --[Number], [ConditionNumber],/* [TargetMark],*/ [DepartmentId], [MatchKey], [MatchName], [RoleCode]
	, isNull(tmc.MemberCount,0) as MemberCount
	FROM 
	[dbo].[ConditionTarget] ct 
	inner join [dbo].[Target] t on t.[Number] = ct.[TargetNumber]
	left outer join fnTargetMemberCount(@surveyNumber) tmc on tmc.TargetNumber = t.Number

	where ct.[ConditionNumber] = isNull(@conditionNumber,ct.[ConditionNumber])
	order by [MatchKey]
END

