
CREATE PROCEDURE [dbo].[sp_SignOn_Delete]
	@signOnId int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[SignOn] where [SignOnId] = @signOnId
END
