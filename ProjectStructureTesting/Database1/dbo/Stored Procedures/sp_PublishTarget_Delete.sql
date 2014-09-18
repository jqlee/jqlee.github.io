
CREATE PROCEDURE [dbo].[sp_PublishTarget_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[PublishTarget] where [Number] = @number
END