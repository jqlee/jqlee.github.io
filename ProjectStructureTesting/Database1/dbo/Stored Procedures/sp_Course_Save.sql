
CREATE PROCEDURE [dbo].[sp_Course_Save]
	@id varchar(20)
	,@name nvarchar(100) = null
	,@collegeId varchar(20) = null
	,@year int = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Course] where [Id] = @id ))
	begin
		
		Update [dbo].[Course] set 
			[Name] = isNull(@name, [Name]), 
			[CollegeId] = isNull(@collegeId, [CollegeId]), 
			[Year] = isNull(@year, [Year])
		where [Id] = @id 

	end
	else
	begin
		
		Insert into [dbo].[Course] (
			[Id], 
			[Name], 
			[CollegeId], 
			[Year]
		) values (
			 @id, 
			 @name, 
			 @collegeId, 
			 @year
		)

	end
END


