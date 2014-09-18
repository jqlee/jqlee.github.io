-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetMemberPaper]
	-- Add the parameters for the stored procedure here
	@memberId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select 'cu' as [TargetType], p.* 
	from [Paper] p
	inner join [TargetCourseUser] tcu on tcu.[PaperNumber] = p.[Number]
	where tcu.[UserId] = @memberId
	union 
	Select 'c' as [TargetType], p.* 
	from [Paper] p
	inner join [TargetCourse] tc on tc.[PaperNumber] = p.[Number]
	inner join [CourseStudent] cs on cs.[CourseId] = tc.[CourseId]
	where cs.[UserId] = @memberId
	union
	Select 'd' as [TargetType], p.* 
	from [Paper] p
	inner join [TargetCollege] tc on tc.[PaperNumber] = p.[Number]
	inner join [Student] s on s.[CollegeId] = tc.[CollegeId] and s.[CollGrade] = isNull(tc.[CollGrade], s.[CollGrade]) and s.[CollGroup] = isNull(tc.[CollGroup], s.[CollGroup])
	where s.[Id] = @memberId




END

