
CREATE PROCEDURE [dbo].[sp_RecordQuestionScore_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[RecordQuestionScore] where [Number] = @number
END