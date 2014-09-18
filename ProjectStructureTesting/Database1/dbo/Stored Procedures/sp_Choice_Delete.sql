
CREATE PROCEDURE [dbo].[sp_Choice_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Choice] where [Number] = @number
END