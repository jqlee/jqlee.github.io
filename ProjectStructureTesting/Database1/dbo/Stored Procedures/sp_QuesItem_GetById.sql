
CREATE PROCEDURE [dbo].[sp_QuesItem_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [QuestionNumber], [Text], [Creator], [CreatorName], [IsVisible], [Score]
	FROM [dbo].[QuesItem]
	where [Number] = @number
END


