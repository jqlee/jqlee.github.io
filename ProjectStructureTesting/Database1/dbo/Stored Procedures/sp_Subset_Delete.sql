
CREATE PROCEDURE [dbo].[sp_Subset_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Subset] where [Number] = @number
END