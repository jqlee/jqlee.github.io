
CREATE PROCEDURE [dbo].[sp_SysMark_GetList]
	@name varchar(20) = null

AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [Name], [Text], [Value], [Note], [OutputPattern]
	FROM [dbo].[SysMark]
	where [Name] = isNull(@name,[Name]) and [Enabled] = 1
	order by [value]
END

