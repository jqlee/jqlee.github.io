
CREATE PROCEDURE [dbo].[sp_CourseStudent_GetList]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [StudentId], [CourseId], [IsAudit]
	FROM [dbo].[CourseStudent]
END

