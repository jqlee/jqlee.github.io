
CREATE PROCEDURE [dbo].[sp_TargetCondition_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [SurveyNumber], [TargetMark], [Name], [DepartmentId], [RoleCode], [GroupYear], [MemberGrade], [Creator], [Created]
	FROM [dbo].[TargetCondition]
	where [Number] = @number
END

