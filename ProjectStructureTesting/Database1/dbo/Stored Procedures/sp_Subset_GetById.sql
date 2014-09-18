
CREATE PROCEDURE [dbo].[sp_Subset_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [Dimension], [QuestionNumber], [Text], [SortOrder]
	FROM [dbo].[Subset]
	where [Number] = @number
END

