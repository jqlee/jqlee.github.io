
CREATE PROCEDURE [dbo].[sp_ScoreConfig_GetListByTemplate]
	@templateGuid uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	SELECT  sc.* --[Number], [Name],[SurveyNumber], [Creator], [Created], [Enabled]
	, (select sum(score) from QuestionScore where ConfigNumber = sc.Number) as TotalScore
	FROM [dbo].[ScoreConfig] sc
	inner join dbo.SurveyPaper p on p.Number = sc.PaperNumber
	where p.[Guid] = @templateGuid
	order by isNull(sc.[LastModified],sc.[Created]) desc
END
