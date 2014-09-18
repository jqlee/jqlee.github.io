
CREATE PROCEDURE [dbo].[sp_Course_GetById]
	@id varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Id], [Name], [CollegeId], [Year]
	FROM [dbo].[Course]
	where [Id] = @id
END


