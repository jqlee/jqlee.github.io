
CREATE PROCEDURE [dbo].[sp_PublishDepartment_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [PublishNumber], [DepartmentId]
	FROM [dbo].[PublishDepartment]
	where [Number] = @number
END

