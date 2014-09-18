
CREATE PROCEDURE [dbo].[sp_Target_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [ConditionNumber], /*[TargetMark],*/ [DepartmentId], [MatchKey], [MatchName], [RoleCode]
	FROM [dbo].[Target]
	where [Number] = @number
END

