
CREATE PROCEDURE [dbo].[sp_RecordRawValue_GetList]
	@rawNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [RawNumber], [ChoiceNumber]
	FROM [dbo].[RecordRawValue]
	where [RawNumber] = isNull(@rawNumber,[RawNumber])
END

