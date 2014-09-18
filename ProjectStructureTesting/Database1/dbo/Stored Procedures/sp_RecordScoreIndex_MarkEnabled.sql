-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[sp_RecordScoreIndex_MarkEnabled]
	-- Add the parameters for the stored procedure here
	@guid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update RecordScoreIndex set [Enabled] = 1, [DisableDate] = null where [Guid] = @guid

	END
