
CREATE PROCEDURE [dbo].[sp_College_Delete]
	@id varchar(8)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[College] where [Id] = @id
END
