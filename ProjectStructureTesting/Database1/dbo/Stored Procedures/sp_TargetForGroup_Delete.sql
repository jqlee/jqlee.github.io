
CREATE PROCEDURE [dbo].[sp_TargetForGroup_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetForGroup] where [Number] = @number
END