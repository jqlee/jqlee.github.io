
CREATE PROCEDURE [dbo].[sp_PublishDepartment_GetList]
	@publishNumber int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [PublishNumber], [DepartmentId], [Seme]
	FROM [dbo].[PublishDepartment]
	where [PublishNumber] = isNull(@publishNumber,[PublishNumber])
END
