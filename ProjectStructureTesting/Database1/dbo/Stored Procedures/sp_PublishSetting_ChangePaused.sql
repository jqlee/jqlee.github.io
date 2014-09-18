-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_PublishSetting_ChangePaused
	-- Add the parameters for the stored procedure here
	@number int,
	@paused bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update PublishSetting 
	set [IsPaused] = @paused
	where Number = @number
END
