
CREATE PROCEDURE [dbo].[sp_RecordRawText_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [RawNumber], [ChoiceNumber], [Text]
	FROM [dbo].[RecordRawText]
	where [Number] = @number
END

