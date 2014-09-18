
CREATE PROCEDURE [dbo].[sp_RecordLog_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [SurveyNumber], [RecordNumber], [ItemNumber], [TextAnswer]
	FROM [dbo].[RecordLog]
	where [Number] = @number
END

