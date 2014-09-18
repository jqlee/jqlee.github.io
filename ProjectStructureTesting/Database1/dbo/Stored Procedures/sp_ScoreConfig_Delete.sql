
CREATE PROCEDURE [dbo].[sp_ScoreConfig_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	begin tran t1
		Delete FROM [dbo].[ScoreConfig] where [Number] = @number
		Delete FROM [dbo].[QuestionScore] where ConfigNumber = @number
		Delete FROM [dbo].[ChoiceScore] where ConfigNumber = @number

		exec sp_ScoreLog_DeleteByConfigNumber @number;
	commit tran t1
END