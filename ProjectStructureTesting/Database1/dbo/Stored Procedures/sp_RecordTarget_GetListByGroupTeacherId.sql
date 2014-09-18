
CREATE PROCEDURE [dbo].[sp_RecordTarget_GetListByGroupTeacherId]
	@groupTeacherId varchar(20)
	,@publishNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	if (@publishNumber = 0) set @publishNumber = null

	SELECT rs.*, ps.PeriodYear, ps.PeriodSeme, ps.Name as PublishName
	, ps.OpenDate, ps.CloseDate, ps.QueryDate
	, rsi.[Guid] as [IndexGuid]
	-- 同科平均
	,x.AverageFinalScore, x.AverageStdevpScore
	FROM [dbo].[RecordTarget] rs
	inner join RecordScoreIndex rsi on rsi.Number = rs.IndexNumber
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	inner join PublishSetting ps on ps.Number = sc.PublishNumber

	inner join (
		select rs.PublishNumber,GroupSubjectKey
			,avg(case when rs.CompleteCount = 0 then null else rs.FinalScore end) as AverageFinalScore
			, avg(case when rs.CompleteCount = 0 then null else rs.StdevpScore end) as AverageStdevpScore 
		from [dbo].[RecordTarget] rs 
		where rs.GroupTeacherId = @groupTeacherId
		group by rs.PublishNumber, rs.GroupSubjectKey
	) x on x.GroupSubjectKey = rs.GroupSubjectKey and x.PublishNumber = rs.PublishNumber

	where rs.GroupTeacherId = @groupTeacherId
	and rsi.IsPublished = 1
	and sc.PublishNumber = isNull(@publishNumber, sc.PublishNumber)
	-- and getdate() > ps.QueryDate 
END

/*
declare @groupTeacherId varchar(20) = 'T9100229'
exec sp_RecordTarget_GetListByGroupTeacherId @groupTeacherId,120

select rs.PublishNumber,GroupSubjectKey,avg(case when rs.CompleteCount = 0 then null else rs.FinalScore end ) as AverageFinalScore, avg(rs.StdevpScore) as AverageStdevpScore 
from [dbo].[RecordTarget] rs 
where rs.GroupTeacherId = @groupTeacherId
group by rs.PublishNumber, rs.GroupSubjectKey

--select * from RecordTarget where GroupTeacherId = @groupTeacherId

	SELECT rs.*, ps.PeriodYear, ps.PeriodSeme, ps.Name as PublishName, rsi.[Guid] as [IndexGuid]
	-- 同科平均
	,x.AverageFinalScore, x.AverageStdevpScore
	FROM [dbo].[RecordTarget] rs
	inner join RecordScoreIndex rsi on rsi.Number = rs.IndexNumber
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	inner join PublishSetting ps on ps.Number = sc.PublishNumber
	inner join (
		select rs.PublishNumber,GroupSubjectKey,avg(case when rs.FinalScore = 0 then null else rs.FinalScore end) as AverageFinalScore, avg(rs.StdevpScore) as AverageStdevpScore 
		from [dbo].[RecordTarget] rs 
		where rs.GroupTeacherId = @groupTeacherId
		group by rs.PublishNumber, rs.GroupSubjectKey
	) x on x.GroupSubjectKey = rs.GroupSubjectKey and x.PublishNumber = rs.PublishNumber
	where rs.GroupTeacherId = @groupTeacherId
	and rsi.IsPublished = 1
	and getdate() > ps.QueryDate 

	select rsi.* from RecordScoreIndex rsi
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	where sc.PublishNumber = 112


select  rsi.IsPublished
,rs.* 
from RecordTarget rs
	inner join RecordScoreIndex rsi on rsi.Number = rs.IndexNumber
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	inner join PublishSetting ps on ps.Number = sc.PublishNumber
where rs.GroupTeacherId = @groupTeacherId and rsi.IsPublished = 1

select * from ScoreConfig where Number in (381,388)
select * from RecordScoreIndex where Number in (123,124)
select * from RecordTarget where IndexNumber in (123,124)

	SELECT rs.*, ps.PeriodYear, ps.PeriodSeme, ps.Name as PublishName, rsi.[Guid] as [IndexGuid]
	-- 同科平均
	,x.AverageFinalScore, x.AverageStdevpScore
	FROM [dbo].RecordTarget rs
	inner join RecordScoreIndex rsi on rsi.Number = rs.IndexNumber
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	inner join PublishSetting ps on ps.Number = sc.PublishNumber
	inner join (
		select GroupSubjectKey,avg(rs.FinalScore) as AverageFinalScore, avg(rs.StdevpScore) as AverageStdevpScore from [dbo].[RecordTarget] rs 
		where rs.GroupTeacherId = @groupTeacherId
		group by GroupSubjectKey
	) x on x.GroupSubjectKey = rs.GroupSubjectKey
	where rs.GroupTeacherId = @groupTeacherId
	and rsi.IsPublished = 1
	and getdate() > ps.QueryDate 
*/