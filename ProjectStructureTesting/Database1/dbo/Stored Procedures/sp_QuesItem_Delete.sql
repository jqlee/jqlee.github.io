
CREATE PROCEDURE [dbo].[sp_QuesItem_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[QuesItem] where [Number] = @number
END
