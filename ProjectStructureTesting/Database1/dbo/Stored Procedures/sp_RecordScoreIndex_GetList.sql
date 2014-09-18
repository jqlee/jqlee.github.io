
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_GetList]
	@configNumber int = 0
	,@creator varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	if (@configNumber = 0) set @configNumber = null;
	SELECT 
		--job.Done as JobHasDone
		Convert(bit, case when j.CompleteCount = j.TotalCount then 1 else 0 end) as JobHasDone
		, j.TotalCount as QueueTotalCount
		, j.CompleteCount as QueueCompleteCount
		,rsi.* --[Number], [ConfigNumber], [Created], [Creator], [RecordCount], [Guid]
		,m.Name as CreatorName
		--, sp.Number as PaperNumber
		, ps.[Guid] as SurveyId
	FROM [dbo].[RecordScoreIndex] rsi
	inner join [ScoreConfig] cs on cs.Number = rsi.ConfigNumber
	--inner join [SurveyPaper] sp on sp.Number = cs.SurveyNumber
	inner join [PublishSetting] ps on ps.Number = cs.PublishNumber /*ps.Number = sp.PublishNumber and ps.LastPublishVersion = sp.PublishVersion*/
	left outer join v_Member m on m.Id = rsi.Creator
	--left outer join SqlJob_SaveScore job on job.IndexGuid = rsi.[Guid] and job.[Enabled] = 1

	left outer  join (
		select rsi.Number as IndexNumber
		,count(rt.Number) as TotalCount
		,sum(case when rt.Done = 1 then 1 else 0 end) as CompleteCount
		from RecordScoreIndex rsi
		inner join RecordTarget rt on rt.IndexNumber = rsi.Number
		where rsi.[ConfigNumber] = @configNumber
		group by rsi.Number
	) j on j.IndexNumber = rsi.Number

	where rsi.[ConfigNumber] = isNull(@configNumber,rsi.[ConfigNumber])
	 and rsi.[Creator] = isNull(@creator,rsi.[Creator])
	 and (rsi.[Enabled] = 1 or (rsi.[Enabled] = 0 and DATEDIFF(minute, rsi.[DisableDate], getdate()) < 1440 ))
END
/*
exec sp_RecordScoreIndex_GetList 395
exec sp_RecordScoreIndex_GetList 395


select 
count(rt.Number) as TotalCount
,count(rt.Done) as CompleteCount
from RecordScoreIndex rsi
inner join RecordTarget rt on rt.IndexNumber = rsi.Number
where rsi.Guid = @indexGuid


select * from PublishSetting where [Guid] = 'fcd65a8d-5a82-484c-aaa9-14a81f4581cc'
select * from [RecordScoreIndex] rsi
inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
where publishNumber = 110

select -1 * (1000+1000*rand())

select dateadd(minute,  -1 * (1000+1000*rand()), getdate())


select DATEDIFF(minute, '2014-04-11 14:20:00', getdate())
select DATEDIFF(minute, '2014-04-11 15:20:00', getdate())
select DATEDIFF(minute, '2014-04-11 16:20:00', getdate())


update RecordScoreIndex set DisableDate =  dateadd(minute,  -1 * (1000+1000*rand()), getdate())
where Number = (Select top 1 number from RecordScoreIndex where [Enabled] = 0 order by newid())
select * from RecordScoreIndex where [Enabled] = 0 


select * from PublishSetting where [Guid] = '992c6ff5-9e61-4d0a-858b-57008612660c'
select * from ScoreConfig where Name = '期末評鑑'
select * from RecordScoreIndex

declare @configNumber int = 396

select rsi.Number as IndexNumber
,count(rt.Number) as TotalCount
,sum(case when rt.Done = 1 then 1 else 0 end) as CompleteCount
from RecordScoreIndex rsi
inner join RecordTarget rt on rt.IndexNumber = rsi.Number
where rsi.[ConfigNumber] = @configNumber
group by rsi.Number

select * from RecordScoreIndex where ConfigNumber = @configNumber
select * from RecordTarget where IndexNumber = 173

	SELECT 
		job.Done as JobHasDone
		,rsi.* --[Number], [ConfigNumber], [Created], [Creator], [RecordCount], [Guid]
		,m.Name as CreatorName
		--, sp.Number as PaperNumber
		, ps.[Guid] as SurveyId
	FROM [dbo].[RecordScoreIndex] rsi
	inner join [ScoreConfig] cs on cs.Number = rsi.ConfigNumber
	--inner join [SurveyPaper] sp on sp.Number = cs.SurveyNumber
	inner join [PublishSetting] ps on ps.Number = cs.PublishNumber /*ps.Number = sp.PublishNumber and ps.LastPublishVersion = sp.PublishVersion*/
	left outer join v_Member m on m.Id = rsi.Creator
	left outer join SqlJob_SaveScore job on job.IndexGuid = rsi.[Guid]
	where rsi.[ConfigNumber] = isNull(@configNumber,rsi.[ConfigNumber])
	-- and rsi.[Creator] = isNull(@creator,rsi.[Creator])
	 and (rsi.[Enabled] = 1 or (rsi.[Enabled] = 0 and DATEDIFF(minute, rsi.[DisableDate], getdate()) < 1440 ))


*/