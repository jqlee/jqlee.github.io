
CREATE PROCEDURE [dbo].[sp_CourseStudent_GetById]
	@studentId varchar(20) = null
	,@courseId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [StudentId], [CourseId], [IsAudit]
	FROM [dbo].[CourseStudent]
	where [StudentId] = @studentId
	 and [CourseId] = @courseId
END


