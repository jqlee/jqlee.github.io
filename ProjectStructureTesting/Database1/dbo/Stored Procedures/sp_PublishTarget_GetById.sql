
CREATE PROCEDURE [dbo].[sp_PublishTarget_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 *-- [Number], [PublishNumber], [GroupYear], [GroupSeme], [GroupGrade], [GroupRole], [MemberGrade], [MemberRole]
	FROM [dbo].[PublishTarget]
	where [Number] = @number
END

