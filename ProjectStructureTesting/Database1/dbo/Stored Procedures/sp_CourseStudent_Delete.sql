
CREATE PROCEDURE [dbo].[sp_CourseStudent_Delete]
	@studentId varchar(20)
	,@courseId varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[CourseStudent] where [StudentId] = @studentId
	 and [CourseId] = @courseId
END
