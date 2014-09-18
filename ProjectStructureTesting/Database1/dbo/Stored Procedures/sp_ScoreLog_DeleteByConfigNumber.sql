-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_ScoreLog_DeleteByConfigNumber
	-- Add the parameters for the stored procedure here
	@configNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @logNumber int;
    -- Insert statements for procedure here
	while (exists( select 0 from ScoreLog WHERE configNumber = @configNumber))
	begin
		select @logNumber = [Number] from ScoreLog WHERE configNumber = @configNumber
		exec sp_ScoreLog_Delete @logNumber;
	end
END
