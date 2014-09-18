
CREATE PROCEDURE [dbo].[sp_PublishPaper_GetList]
	@publishNumber int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [Title], [Description], [Created], [PublishNumber], [CopySource], [Guid]
	FROM [dbo].[PublishPaper]
	where [PublishNumber] = isNull(@publishNumber,[PublishNumber])
END
