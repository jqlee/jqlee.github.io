
CREATE PROCEDURE [dbo].[sp_College_GetById]
	@id varchar(8) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Id], [Name], [ShortName]
	FROM [dbo].[College]
	where [Id] = @id
END


