
CREATE PROCEDURE [dbo].[sp_Condition_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [SurveyNumber], [TargetMark], [Keyword], [GroupYear], [RoleCode], [MemberGrade], [Name], [Creator], [Created]
	FROM [dbo].[Condition]
	where [Number] = @number
END

