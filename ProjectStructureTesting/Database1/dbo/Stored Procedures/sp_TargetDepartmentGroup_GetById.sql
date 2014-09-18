
CREATE PROCEDURE [dbo].[sp_TargetDepartmentGroup_GetById]
	@surveyNumber int = null
	,@groupId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [SurveyNumber], [GroupId], [IncludingAuditor], [Name]
	FROM [dbo].[TargetDepartmentGroup]
	where [SurveyNumber] = @surveyNumber
	 and [GroupId] = @groupId
END


