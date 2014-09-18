-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_MarkDisabled]
	-- Add the parameters for the stored procedure here
	@guid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update RecordScoreIndex set [Enabled] = 0, [DisableDate] = getdate() where [Guid] = @guid

	END
