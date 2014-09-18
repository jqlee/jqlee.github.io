-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_PublishSetting_GetByConfigGuid
	-- Add the parameters for the stored procedure here
	@configGuid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ps.* from ScoreConfig sc
		inner join PublishSetting ps on ps.Number = sc.PublishNumber
		where sc.[guid] = @configGuid

END
