
CREATE PROCEDURE [dbo].[sp_Department_GetById]
	@id varchar(8)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 *
	FROM [dbo].[v_Department]
	where [Id] = @id
END


