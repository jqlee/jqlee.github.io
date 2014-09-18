
CREATE PROCEDURE [dbo].[sp_Question_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Question] where [Number] = @number
END
