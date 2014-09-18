
CREATE PROCEDURE [dbo].[sp_SysMark_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[SysMark] where [Number] = @number
END
