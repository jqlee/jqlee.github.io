
CREATE PROCEDURE [dbo].[sp_TargetDepartmentGroup_Delete]
	@surveyNumber int
	,@groupId varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetDepartmentGroup] where [SurveyNumber] = @surveyNumber
	 and [GroupId] = @groupId
END
