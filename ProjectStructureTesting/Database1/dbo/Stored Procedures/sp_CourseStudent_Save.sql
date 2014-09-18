
CREATE PROCEDURE [dbo].[sp_CourseStudent_Save]
	@studentId varchar(20)
	,@courseId varchar(20)
	,@isAudit bit = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[CourseStudent] where [StudentId] = @studentId and [CourseId] = @courseId ))
	begin
		
		Update [dbo].[CourseStudent] set 
			[IsAudit] = isNull(@isAudit, [IsAudit])
		where [StudentId] = @studentId and [CourseId] = @courseId 

	end
	else
	begin
		
		Insert into [dbo].[CourseStudent] (
			[StudentId], 
			[CourseId], 
			[IsAudit]
		) values (
			 @studentId, 
			 @courseId, 
			 @isAudit
		)

	end
END


