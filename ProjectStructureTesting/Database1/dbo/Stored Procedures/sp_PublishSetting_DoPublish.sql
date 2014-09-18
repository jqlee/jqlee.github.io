
CREATE PROCEDURE [dbo].[sp_PublishSetting_DoPublish]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	--Delete FROM [dbo].[PublishSetting] where [Number] = @number
	-- 1.將問卷範本輸出成問卷，標記發布編號與版本，版本最低是1
	-- 1.1 複製問卷時須一併複製的項目: 題目、分數設定
	--sp_ScoreConfig_Copy
	--sp_Question_CopyAll
	-- 2.更新發布設定

	begin tran Tps

	declare @publishNumber int = @number
	declare @publishVersion smallint

--	select @publishVersion = count(Number)+1 from SurveyPaper 
--		where PublishNumber = @publishNumber

	select @publishVersion = max(isNull(LastPublishVersion,0))+1 from PublishSetting 
		where Number = @publishNumber
	--print @publishVersion;

	declare @paperNumber int = 0,@newPaperNumber int = 0
	declare @publishCount int = 0, @groupCount int = 0

	select @paperNumber = p.Number 
	from PublishSetting ps inner join SurveyPaper p on p.[Guid] = ps.[TemplateId]
	where ps.Number = @publishNumber

	select @publishCount = [TotalCount] 
	from v_SurveyStatus where PublishNumber = @publishNumber
	--print @publishCount
	

	declare @t Table (Idx int identity(1,1), ConfigNumber int , IndexGuid uniqueidentifier, Creator varchar(20) /*, PublishCount int */ )

	if (@paperNumber > 0)
	begin
		declare @newPaperGuid uniqueidentifier = newid()
		exec sp_SurveyPaper_Copy @paperNumber=@paperNumber,@newPublishNumber=@publishNumber,@newGuid=@newPaperGuid;

		update [SurveyPaper] 
		set IsTemplate = 0, PublishNumber = @publishNumber, [PublishVersion] = @publishVersion, PublishDate = getdate()
		where [Guid] = @newPaperGuid;

		-- 查詢分數設定，為每一項建立index
		select @newPaperNumber = [Number] from [SurveyPaper] where [Guid] = @newPaperGuid;
		-- print @newPaperGuid

		insert into @t (ConfigNumber,IndexGuid,Creator /*,PublishCount*/ )
		Select sc.Number as ConfigNumber, newid() as IndexGuid, ps.Creator --, ss.TotalCount as PublishCount
		from [SurveyPaper] p
		inner join PublishSetting ps on ps.Number = p.PublishNumber
		inner join ScoreConfig sc on sc.PaperNumber = p.Number
		--inner join v_SurveyStatus ss on ss.PublishNumber = p.PublishNumber
		where p.[Guid] = @newPaperGuid and sc.[Enabled] = 1;

		insert into [RecordScoreIndex] (ConfigNumber, [Guid], Creator, RecordCount)
		select ConfigNumber,IndexGuid,Creator,@publishCount as RecordCount from @t

		--select * from @t

		declare @indexGuid uniqueidentifier
		while (exists(select 0 from @t))
		begin
			select @indexGuid = IndexGuid from @t
			exec sp_RecordScoreIndex_SaveScore_CreateQueue @indexGuid

			-- 先標紀成完成
			update rt set rt.Done = 1
			from RecordTarget rt 
			inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
			where rsi.[Guid] = @indexGuid

			delete from @t where IndexGuid = @indexGuid
		end


	end

	select @groupCount = Max(GroupCount) from (
	select count(*) as GroupCount from RecordTarget where PublishNumber = @publishNumber Group by IndexNumber
	) x

	update PublishSetting set IsPublished = 1 , [LastPublishVersion] = @publishVersion, PublishCount = @publishCount, GroupCount = @groupCount
	where Number = @publishNumber

	--Update [dbo].[PublishSetting] set [IsPublished] = 1 where [Number] = @number

	commit tran Tps
END



--select * from SurveyPaper order by Number desc
/*

update PublishSetting set GroupCount = (select top 1 count(*) from RecordTarget where PublishNumber = PublishSetting.Number Group by IndexNumber)
where GroupCount is null

exec sp_PublishSetting_DoPublish 101
select * from PublishSetting where Number = 101
select * from v_SurveyStatus where PublishNumber = 101

select * from SurveyPaper order by number desc

select top 1 count(*) as GroupCount from RecordTarget where PublishNumber = 120 Group by IndexNumber

declare @newPaperGuid uniqueidentifier = 'F804791E-AA13-4071-B3EE-61C51FF7168C'
Select sc.Number as ConfigNumber, ss.CompleteCount, ss.TotalCount, ps.Creator
from [SurveyPaper] p
inner join PublishSetting ps on ps.Number = p.PublishNumber
inner join ScoreConfig sc on sc.PaperNumber = p.Number
inner join v_SurveyStatus ss on ss.PublishNumber = p.PublishNumber
where p.[Guid] = @newPaperGuid;

select * from v_SurveyStatus where PublishNumber = 


select * from PublishSetting
select * from RecordTarget where (PublishNumber = 120 or PublishNumber = 116) and Done = 0


declare @recordNumber int = 43315
exec sp_RecordTarget_UpdateDoneStatusByRecord @recordNumber,0

Update rt set rt.[Done] = 0
from Record r
inner join RecordTarget rt on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
where r.Number = @recordNumber



		Select sc.Number as ConfigNumber, newid() as IndexGuid, ps.Creator, ss.TotalCount
		from [SurveyPaper] p
		inner join PublishSetting ps on ps.Number = p.PublishNumber
		inner join ScoreConfig sc on sc.PaperNumber = p.Number
		inner join v_SurveyStatus ss on ss.PublishNumber = p.PublishNumber
		where p.[Guid] = '15CC0331-5A64-422F-99AD-4FA14E92767A' and sc.[Enabled] = 1;


declare @recordNumber int = 43320, @doneStatus bit = 0
select @recordNumber = Max(Number) from Record
--exec sp_RecordTarget_UpdateDoneStatusByRecord @recordNumber,@doneStatus
select rt.Done,*  
from Record r
inner join RecordTarget rt on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
where r.Number = @recordNumber

select * from v_SurveyStatus where PublishNumber = 120

SELECT PublishNumber, GroupId, GroupTeacherId, GroupRole
, SUM(CASE WHEN RecordNumber IS NOT NULL THEN 1 ELSE 0 END) AS RecordCount
, SUM(CASE WHEN RecordDone = 1 THEN 1 ELSE 0 END) AS CompleteCount
, COUNT(MemberId) AS TotalCount
FROM dbo.v_MatchRecord mr
GROUP BY   PublishNumber, GroupId, GroupTeacherId, GroupRole

declare @publishGuid uniqueidentifier
select r.RecordCount, r.CompleteCount, r.TotalCount, t.* 
from PublishSetting ps
inner join dbo.v_Ticket t on t.PublishNumber = ps.Number
inner join (
SELECT PublishNumber, GroupId, GroupTeacherId, GroupRole
, SUM(CASE WHEN RecordNumber IS NOT NULL THEN 1 ELSE 0 END) AS RecordCount
, SUM(CASE WHEN RecordDone = 1 THEN 1 ELSE 0 END) AS CompleteCount
, COUNT(MemberId) AS TotalCount
FROM dbo.v_MatchRecord mr
GROUP BY   PublishNumber, GroupId, GroupTeacherId, GroupRole
) r on r.GroupId = t.GroupId and r.GroupTeacherId = t.GroupTeacherId and r.GroupRole = t.GroupRole
where ps.[Guid] = @publishGuid



declare @indexGuid uniqueidentifier = 'faeed341-023e-4cf0-a376-f13780765688', @recordCount int = 0
select q.Title as QuestionTitle, qs.Score/100 as QuestionRate, x.*
from (
	select x.ConfigNumber , x.QuestionNumber
		, Avg(AnswerRate) as QuestionAnswerRate
		, Avg(GainAverage) as QuestionFinal
		, Avg(GainStdevp) as QuestionStdevp
		from (
		select rsi.ConfigNumber, rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber
		, count(distinct rqs.RecordNumber) as AnswerCount
		, (case when @recordCount > 0 then Convert(float, count(distinct rqs.RecordNumber))/@recordCount else 0 end) as AnswerRate
		, Avg(RawScore) as GainAverage
		, STDEVP(RawScore) as GainStdevp
		from RecordTarget rt 
		inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
		inner join RecordQuestionScore rqs on rqs.TargetNumber = rt.Number
		where rsi.[Guid] = @indexGuid
		group by rsi.ConfigNumber , rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber
	) x
	group by x.ConfigNumber , x.QuestionNumber
) x
inner join Question q on q.Number = x.QuestionNumber
inner join QuestionScore qs on qs.ConfigNumber = x.ConfigNumber and qs.QuestionNumber = x.QuestionNumber
order by q.SortOrder


select * from publishsetting where [guid] = '4c8938f0-aa59-410a-a2cb-0da82ed45dd4'
select IndexNumber,count(*) from RecordTarget where PublishNumber = 88 group by IndexNumber

select * from [SqlJob_SaveScore] where IndexGuid = '91483c40-183f-4ffb-93b5-97a61b269150' and [Enabled] = 1
*/
