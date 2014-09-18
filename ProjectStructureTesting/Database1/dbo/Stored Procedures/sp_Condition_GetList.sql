
CREATE PROCEDURE [dbo].[sp_Condition_GetList]
	@surveyNumber int = null

AS
BEGIN
	SET NOCOUNT ON;
	SELECT tc.*--[Number], [SurveyNumber], [TargetMark], [Keyword], [GroupYear], [RoleCode], [MemberGrade], [Name], [Creator], [Created]
	,r.RoleName
	, isNull(ctc.TargetCount,0) as TargetCount
	--, (select count(*) from [TargetForDepartment] where [ConditionNumber] = tc.[Number]) as [TargetCount]
	, isNull(cmc.MemberCount,0) as TotalMemberCount

	FROM [dbo].[Condition] tc
	left outer join v_Role r on r.RoleCode = tc.RoleCode
	left outer join fnConditionMemberCount(@surveyNumber) cmc on cmc.ConditionNumber = tc.Number
	left outer join (
		Select c.Number,count(t.Number) as TargetCount 
		from Condition c
		inner join ConditionTarget ct on ct.ConditionNumber = c.Number
		inner join [Target] t on t.Number = ct.TargetNumber 
		where c.SurveyNumber = @surveyNumber
		group by c.Number
	) ctc on ctc.Number =tc.Number

	where tc.[SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])

END


/*
select t.* from Condition c
	inner join ConditionTarget ct on ct.ConditionNumber = c.Number
	inner join Target t on t.Number = ct.TargetNumber
	where c.SurveyNumber = @surveyNumber

*/