
CREATE PROCEDURE [dbo].[sp_RecordLog_Save]
	@number int
	,@surveyNumber int = null
	,@recordNumber int = null
	,@itemNumber int = null
	,@textAnswer nvarchar(MAX) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[RecordLog] where [Number] = @number ))
	begin
		
		Update [dbo].[RecordLog] set 
			[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			[RecordNumber] = isNull(@recordNumber, [RecordNumber]), 
			[ItemNumber] = isNull(@itemNumber, [ItemNumber]), 
			[TextAnswer] = isNull(@textAnswer, [TextAnswer])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[RecordLog] (
			[SurveyNumber], 
			[RecordNumber], 
			[ItemNumber], 
			[TextAnswer]
		) values (
			 @surveyNumber, 
			 @recordNumber, 
			 @itemNumber, 
			 @textAnswer
		)

	end
END

