
CREATE PROCEDURE [dbo].[sp_Department_Delete]
	@id varchar(8)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Department] where [Id] = @id
END
