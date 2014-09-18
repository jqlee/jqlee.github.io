
CREATE PROCEDURE [dbo].[sp_QuesItem_GetList]
	@questionNumber int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [QuestionNumber], [Text], [Creator], [CreatorName], [IsVisible], [Score]
	FROM [dbo].[QuesItem]
	where [QuestionNumber] = isNull(@questionNumber,[QuestionNumber])
END

