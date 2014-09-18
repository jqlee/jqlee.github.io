
CREATE PROCEDURE [dbo].[sp_SurveyTemplate_GetList]
	@creator varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [Title], [Description], [Enabled], [Creator], [Created], [LastModified], [Guid]
	FROM [dbo].[SurveyTemplate]
	where [Creator] = isNull(@creator,[Creator])
END
