
CREATE PROCEDURE [dbo].[sp_ViewPermission_DeleteAll]
	@publishNumber int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[ViewPermission] where [PublishNumber] = @publishNumber
END