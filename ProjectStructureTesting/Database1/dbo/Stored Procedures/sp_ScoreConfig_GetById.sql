
CREATE PROCEDURE [dbo].[sp_ScoreConfig_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 sc.* --[Number], [Name],[SurveyNumber], [Creator], [Created], [Enabled]
	, p.Number as PaperNumber , p.[Guid] as PaperGuid, p.PublishNumber,p.PublishVersion, ps.[Guid] as [PublishGuid]
	, m.Name as [CreatorName]
	FROM [dbo].[ScoreConfig] sc
	left outer join v_Member m on m.Id = sc.[Creator]
	inner join dbo.SurveyPaper p on p.Number = sc.PaperNumber
	inner join dbo.PublishSetting ps on ps.Number = p.PublishNumber and p.PublishVersion = ps.LastPublishVersion

	where sc.[Number] = @number
END

