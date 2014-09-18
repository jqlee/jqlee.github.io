
CREATE PROCEDURE [dbo].[sp_RecordRawValue_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [RawNumber], [ChoiceNumber]
	FROM [dbo].[RecordRawValue]
	where [Number] = @number
END

