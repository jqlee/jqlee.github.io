
CREATE PROCEDURE [dbo].[sp_Course_Delete]
	@id varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Course] where [Id] = @id
END
