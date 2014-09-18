
CREATE PROCEDURE [dbo].[sp_SurveyPaper_GetPublished]
	@publishNumber int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 p.* --[Number], [Title], [Description], [Enabled], [Creator], [Created], [LastModified], [Guid], [IsTemplate]
	FROM [dbo].[PublishSetting] ps
	inner join [dbo].[SurveyPaper] p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	where ps.[Number] = @publishNumber and IsTemplate = 0
END

