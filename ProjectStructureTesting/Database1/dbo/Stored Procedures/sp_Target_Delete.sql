
CREATE PROCEDURE [dbo].[sp_Target_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Target] where [Number] = @number
END