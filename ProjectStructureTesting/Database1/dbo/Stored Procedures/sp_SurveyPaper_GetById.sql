
Create PROCEDURE [dbo].[sp_SurveyPaper_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 * --[Number], [Title], [Description], [Enabled], [Creator], [Created], [LastModified], [Guid], [IsTemplate]
	FROM [dbo].[SurveyPaper]
	where [Number] = @number
END

