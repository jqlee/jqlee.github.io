
Create PROCEDURE [dbo].[sp_Question_DeleteByGuid]
	@id uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[Question] where [Guid] = @id
END
