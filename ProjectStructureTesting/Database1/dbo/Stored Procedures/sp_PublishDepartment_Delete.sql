
CREATE PROCEDURE [dbo].[sp_PublishDepartment_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[PublishDepartment] where [Number] = @number
END