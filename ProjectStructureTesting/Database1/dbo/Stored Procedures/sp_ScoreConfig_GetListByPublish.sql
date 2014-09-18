
CREATE PROCEDURE [dbo].[sp_ScoreConfig_GetListByPublish]
	@publishGuid uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	SELECT sc.* --[Number], [Name],[SurveyNumber], [Creator], [Created], [Enabled]
	, p.Number as PaperNumber , p.[Guid] as PaperGuid, p.PublishNumber,p.PublishVersion, ps.[Guid] as [PublishGuid]
	, (select sum(score) from QuestionScore where ConfigNumber = sc.Number) as TotalScore
	,Convert(bit, case when j.CompleteCount = j.TotalCount then 1 else 0 end) as JobHasDone
	, Convert(int,isNull(j.TotalCount,0)) as QueueTotalCount
	, Convert(int,isNull(j.CompleteCount,0)) as QueueCompleteCount
	, j.IndexNumber, j.IndexGuid
	, Convert(bit,isNull(j.IsPublished,0)) as [IsPublished]
	FROM [dbo].[ScoreConfig] sc
	inner join dbo.SurveyPaper p on p.Number = sc.PaperNumber
	inner join dbo.PublishSetting ps on ps.Number = p.PublishNumber and p.PublishVersion = ps.LastPublishVersion

	left outer  join (
		select rsi.Number as IndexNumber, rsi.ConfigNumber, rsi.IsPublished
		,rsi.[Guid] as IndexGuid
		,rsi.Created as IndexCreated
		, x.CompleteCount, x.TotalCount
		from RecordScoreIndex rsi
		inner join (
			select rsi.Number as IndexNumber
			,count(rt.Number) as TotalCount
			,sum(case when rt.Done = 1 then 1 else 0 end) as CompleteCount
			from RecordScoreIndex rsi
			inner join RecordTarget rt on rt.IndexNumber = rsi.Number
			where rsi.[Enabled] = 1
			group by rsi.Number, rsi.ConfigNumber, rsi.IsPublished
		) x on x.IndexNumber = rsi.Number
	) j on j.ConfigNumber = sc.Number

	where ps.[Guid] = @publishGuid
	order by isNull(sc.[LastModified],sc.[Created]) desc
END
/*
exec sp_ScoreConfig_GetListByPublish '10b22d37-7930-41f1-8b32-7ef1824202fe'
exec sp_ScoreConfig_GetListByPublish '992c6ff5-9e61-4d0a-858b-57008612660c'
*/