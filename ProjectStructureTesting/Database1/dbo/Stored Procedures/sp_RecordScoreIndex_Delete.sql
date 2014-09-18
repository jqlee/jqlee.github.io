
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[RecordScoreIndex] where [Number] = @number
END