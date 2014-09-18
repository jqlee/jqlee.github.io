
CREATE PROCEDURE [dbo].[sp_SurveyPaper_GetByPublish]
	@publishGuid uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	select p.* 
	from SurveyPaper p
	inner join PublishSetting ps on p.PublishVersion = ps.LastPublishVersion and p.PublishNumber = ps.Number
	where ps.[Guid] = @publishGuid

END

