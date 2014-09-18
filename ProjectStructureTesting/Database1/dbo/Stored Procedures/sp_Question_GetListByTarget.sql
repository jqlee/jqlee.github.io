
CREATE PROCEDURE [dbo].[sp_Question_GetListByTarget]
	@targetGuid uniqueidentifier
	--,@indexNumber int = 0
	,@checkPermission bit = 0
AS
BEGIN
	SET NOCOUNT ON;

	select Convert(float,isNull(qs.Score,0)) as QuestionRate, q.Number as QuestionNumber, q.* 
	from [RecordTarget] rt
	inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
	--inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	inner join [PublishSetting] ps on ps.Number = rt.PublishNumber
	inner join [SurveyPaper] p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	inner join Question q on q.SurveyNumber = p.Number
	left outer join (
		Select distinct vp.PublishNumber, vp.QuestionNumber 
		from ViewPermission vp
	) vp on vp.PublishNumber = rt.PublishNumber and vp.QuestionNumber = q.Number
	left outer join QuestionScore qs on qs.QuestionNumber = q.Number and qs.ConfigNumber = rsi.ConfigNumber
	where rt.[Guid] = @targetGuid
	and 1 = case 
		when @checkPermission = 1 and vp.QuestionNumber is null then 0 else 1 end
	order by q.[Section],q.[SortOrder]

END

/*
--exec sp_Question_GetListByTarget '67ced38e-c41c-4447-99cc-4929dd206127'

declare @targetGuid uniqueidentifier = '67ced38e-c41c-4447-99cc-4929dd206127'
,@needPermission bit = 0
	select Convert(float,isNull(qs.Score,0)) as QuestionRate, q.Number as QuestionNumber, q.* 
	from [RecordTarget] rt
	inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
	--inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	inner join [PublishSetting] ps on ps.Number = rt.PublishNumber
	inner join [SurveyPaper] p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	inner join Question q on q.SurveyNumber = p.Number
	left outer join (
		Select distinct vp.PublishNumber, vp.QuestionNumber 
		from ViewPermission vp
	) vp on vp.PublishNumber = rt.PublishNumber and vp.QuestionNumber = q.Number
	left outer join QuestionScore qs on qs.QuestionNumber = q.Number and qs.ConfigNumber = rsi.ConfigNumber
	where rt.[Guid] = @targetGuid
	and 1 = case 
		when @needPermission = 1 and vp.QuestionNumber is null then 0 else 1 end
	order by q.[Section],q.[SortOrder]


*/