
CREATE PROCEDURE [dbo].[sp_SurveyTemplate_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[SurveyTemplate] where [Number] = @number
END