
CREATE PROCEDURE [dbo].[sp_SignOn_GetBySessionId]
	@sessionId varchar(50) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 *
	FROM [dbo].[v_SignOn]
	where [sessionid] = @sessionId
END


