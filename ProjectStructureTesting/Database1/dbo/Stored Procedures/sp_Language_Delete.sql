
CREATE PROCEDURE [dbo].[sp_Language_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Language] where [Number] = @number
END