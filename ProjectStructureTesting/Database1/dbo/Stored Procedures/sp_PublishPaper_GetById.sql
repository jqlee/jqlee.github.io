
CREATE PROCEDURE [dbo].[sp_PublishPaper_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [Title], [Description], [Created], [PublishNumber], [CopySource], [Guid]
	FROM [dbo].[PublishPaper]
	where [Number] = @number
END

