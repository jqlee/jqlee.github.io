
CREATE PROCEDURE [dbo].[sp_RecordLog_GetList]
	@surveyNumber int = null
	,@recordNumber int = null
	,@itemNumber int = null
AS
BEGIN
	if (@surveyNumber = 0) set @surveyNumber = null;
	if (@recordNumber = 0) set @recordNumber = null;
	if (@itemNumber = 0) set @itemNumber = null;
	SET NOCOUNT ON;
	SELECT [Number], [SurveyNumber], [RecordNumber], [ItemNumber], [TextAnswer]
	FROM [dbo].[RecordLog]
	where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
	 and [RecordNumber] = isNull(@recordNumber,[RecordNumber])
	 and [ItemNumber] = isNull(@itemNumber,[ItemNumber])
	order by [ItemNumber]
END
