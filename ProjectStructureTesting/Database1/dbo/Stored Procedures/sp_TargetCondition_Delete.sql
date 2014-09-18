
CREATE PROCEDURE [dbo].[sp_TargetCondition_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetCondition] where [Number] = @number
END