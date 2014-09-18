
CREATE PROCEDURE [dbo].[sp_SignOn_GetById]
	@signOnId int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 *
	FROM [dbo].[v_SignOn]
	where [SignOnId] = @signOnId
END


