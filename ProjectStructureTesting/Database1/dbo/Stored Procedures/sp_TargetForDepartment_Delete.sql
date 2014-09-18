
CREATE PROCEDURE [dbo].[sp_TargetForDepartment_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetForDepartment] where [Number] = @number
END