
CREATE PROCEDURE [dbo].[sp_RecordTarget_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 *
	FROM [dbo].[RecordTarget]
	where [Number] = @number
END

