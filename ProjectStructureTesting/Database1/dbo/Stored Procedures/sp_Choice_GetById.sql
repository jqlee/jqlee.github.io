
CREATE PROCEDURE [dbo].[sp_Choice_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [QuestionNumber], [Text], [SortOrder], [AcceptText], [IsJoined]
	FROM [dbo].[Choice]
	where [Number] = @number
END

