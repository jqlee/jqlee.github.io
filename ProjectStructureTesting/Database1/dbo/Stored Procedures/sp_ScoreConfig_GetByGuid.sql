
CREATE PROCEDURE [dbo].[sp_ScoreConfig_GetByGuid]
	@guid uniqueidentifier = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 sc.* --[Number], [Name],[SurveyNumber], [Creator], [Created], [Enabled]
	, m.Name as [CreatorName]
	FROM [dbo].[ScoreConfig] sc
	left outer join v_Member m on m.Id = sc.[Creator]
	where sc.[Guid] = @guid
END

