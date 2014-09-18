
Create PROCEDURE [dbo].[sp_Target_FindList]
	@surveyNumber int = 0
	,@keyword nvarchar(20) = null

AS
BEGIN
	SET NOCOUNT ON;


	SELECT t.* --[Number], [ConditionNumber],/* [TargetMark],*/ [DepartmentId], [MatchKey], [MatchName], [RoleCode]
	, isNull(tmc.MemberCount,0) as MemberCount
	, isNull(tmc.RecordCount,0) as RecordCount
	FROM [dbo].[Target] t
	--left outer join fnTargetMemberCount(@conditionNumber) tmc on tmc.TargetNumber = t.Number
	left outer join fnSurveyMemberCount(@surveyNumber) tmc on tmc.TargetNumber = t.Number
	
	where t.SurveyNumber = @surveyNumber --and c.ConditionNumber = isNull(@conditionNumber,c.ConditionNumber)
	and (case 
		when @keyword is not null and (t.MatchKey like '%'+@keyword+'%' or t.MatchName like '%' + @keyword + '%') then 1 
		when @keyword is null then 1
		else 0 
	end) =1

END