-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_RecordScoreIndex_GetPublished
	-- Add the parameters for the stored procedure here
	@publishNumber int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select rsi.* 
	from RecordScoreIndex rsi
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	inner join PublishSetting ps on ps.Number = sc.PublishNumber
	where ps.Number = @publishNumber and rsi.IsPublished = 1

END
