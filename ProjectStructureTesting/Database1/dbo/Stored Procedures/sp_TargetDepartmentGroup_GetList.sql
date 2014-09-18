
CREATE PROCEDURE [dbo].[sp_TargetDepartmentGroup_GetList]
	@includingAuditor bit = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [SurveyNumber], [GroupId], [IncludingAuditor], [Name]
	FROM [dbo].[TargetDepartmentGroup]
	where [IncludingAuditor] = isNull(@includingAuditor,[IncludingAuditor])
END

