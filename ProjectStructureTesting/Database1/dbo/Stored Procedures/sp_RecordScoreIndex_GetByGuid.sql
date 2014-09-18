
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_GetByGuid]
	@guid uniqueidentifier = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 
		ps.[Guid] as PublishGuid
		, ps.Name as PublishName
		, ps.PublishCount, ps.CompleteCount
		, sc.Name as ConfigName
		, sc.[Guid] as ConfigGuid
		, sc.Number as ConfigNumber
		, rsi.Number as IndexNumber
		, m.Name as CreatorName
		, sc.PaperNumber, sc.PublishNumber, ps.[Guid] as SurveyId
		, rsi.* --[Number], [ConfigNumber], [Created], [Creator], [RecordCount]
	FROM [dbo].[RecordScoreIndex] rsi
	inner join [ScoreConfig] sc on sc.Number = rsi.ConfigNumber
	inner join [PublishSetting] ps on ps.Number = sc.PublishNumber /* ps.Number = sp.PublishNumber and ps.LastPublishVersion = sp.PublishVersion*/
	left outer join v_Member m on m.Id = rsi.Creator
	where rsi.[Guid] = @guid
END

