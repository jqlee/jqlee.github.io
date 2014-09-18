
CREATE PROCEDURE [dbo].[sp_College_GetList]
	@name nvarchar(150) = null
	,@shortName nvarchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Id], [Name], [ShortName]
	FROM [dbo].[College]
	where [Name] = isNull(@name,[Name])
	 and [ShortName] = isNull(@shortName,[ShortName])
END

