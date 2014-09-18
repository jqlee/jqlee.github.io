-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyPaper_SetEnabled]
	-- Add the parameters for the stored procedure here
	@number int
	,@enabled bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update SurveyPaper set [Enabled] = @enabled, [RecycleDate] = getdate()
	where [Number] = @number
END
