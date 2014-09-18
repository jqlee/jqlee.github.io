-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreLog_Delete]
	-- Add the parameters for the stored procedure here
	@number int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    begin tran t1
	delete from [ScoreLog] where Number = @number;

	delete from [ScoreRaw] where LogNumber = @number;
	delete from [ScoreResult] where LogNumber = @number;
	delete from [ScoreMatchStatus] where LogNumber = @number;
	commit tran t1
END
