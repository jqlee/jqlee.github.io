-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreLog_Save]
	-- Add the parameters for the stored procedure here
	@configNumber int = 0
	,@surveyNumber int = 0
	,@recordCount int = 0
	,@creator varchar(20) = null
	,@guid uniqueidentifier = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 只有新增，沒有修改
	Insert into [ScoreLog] ([ConfigNumber],[SurveyNumber],[RecordCount],[Creator],[Created],[Guid])
	values (@configNumber,@surveyNumber,@recordCount, @creator, getdate(),isNull(@guid,newid()))
END
