
CREATE PROCEDURE [dbo].[sp_TargetForGroup_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [SurveyNumber], [GroupId], [MemberId], [TargetMark]
	FROM [dbo].[TargetForGroup]
	where [Number] = @number
END

