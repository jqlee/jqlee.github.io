
CREATE PROCEDURE [dbo].[sp_TargetDepartment_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetDepartment] where [Number] = @number
END
