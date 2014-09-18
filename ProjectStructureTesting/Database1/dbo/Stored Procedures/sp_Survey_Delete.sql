
CREATE PROCEDURE [dbo].[sp_Survey_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Survey] where [Number] = @number
END
