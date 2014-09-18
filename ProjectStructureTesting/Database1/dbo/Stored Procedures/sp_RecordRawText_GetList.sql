
CREATE PROCEDURE [dbo].[sp_RecordRawText_GetList]
	@rawNumber int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [RawNumber], [ChoiceNumber], [Text]
	FROM [dbo].[RecordRawText]
	where [RawNumber] = isNull(@rawNumber,[RawNumber])
END
