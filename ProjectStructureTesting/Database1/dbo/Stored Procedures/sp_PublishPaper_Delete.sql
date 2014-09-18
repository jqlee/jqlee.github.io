
CREATE PROCEDURE [dbo].[sp_PublishPaper_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[PublishPaper] where [Number] = @number
END