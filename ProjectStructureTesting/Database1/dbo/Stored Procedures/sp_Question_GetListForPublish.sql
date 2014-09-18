
Create PROCEDURE [dbo].[sp_Question_GetListForPublish]
	@publishNumber int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT q.*

	FROM [dbo].[Question] q
	inner join [SurveyPaper] p on p.Number = q.SurveyNumber
	inner join [PublishSetting] ps on ps.Number = p.PublishNumber and ps.LastPublishVersion = p.PublishVersion

	where ps.Number = @publishNumber
	order by q.[Section],q.[SortOrder]
END

