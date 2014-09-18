
CREATE PROCEDURE [dbo].[sp_SysMark_GetById]
	@name varchar(20)
	,@value tinyint = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [Name], [Text], [Value], [Note], [OutputPattern]
	FROM [dbo].[SysMark]
	where [name] = @name and [Value] = @value
END


