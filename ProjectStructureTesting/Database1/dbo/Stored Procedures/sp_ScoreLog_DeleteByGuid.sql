-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_ScoreLog_DeleteByGuid
	-- Add the parameters for the stored procedure here
	@guid uniqueidentifier = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	begin tran t1

	delete from [ScoreLog] where [Guid] = @guid

	commit tran t1
END
