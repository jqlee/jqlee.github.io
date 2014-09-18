
CREATE PROCEDURE [dbo].[sp_PublishTarget_GetList]
	@publishNumber int = null

AS
BEGIN
	SET NOCOUNT ON;
	SELECT *--[Number], [PublishNumber], [GroupYear], [GroupSeme], [GroupGrade], [GroupRole], [MemberGrade], [MemberRole]
	FROM [dbo].[PublishTarget]
	where [PublishNumber] = isNull(@publishNumber,[PublishNumber])
END
