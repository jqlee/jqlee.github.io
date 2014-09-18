
CREATE PROCEDURE [dbo].[sp_SurveyTemplate_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [Title], [Description], [Enabled], [Creator], [Created], [LastModified], [Guid]
	FROM [dbo].[SurveyTemplate]
	where [Number] = @number
END

