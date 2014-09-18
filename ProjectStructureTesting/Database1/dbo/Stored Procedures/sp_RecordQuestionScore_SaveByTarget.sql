-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	20140501 變更為可重複執行，每次累加紀錄，增加一個中介表紀錄已存的Record
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordQuestionScore_SaveByTarget]
	-- Add the parameters for the stored procedure here
	@targetNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--declare @

	-- 保存答題紀錄
	--Delete from [RecordQuestionScore] where [TargetNumber] = @targetNumber;

	--set statistics time on
	SET NOCOUNT Off; --啟用此行可觀察寫入狀況

	--
	-- 要同時插入RecordTargetLog以及RecordQuestionScore，因此建暫存表

	declare @t Table ([Idx] int identity(1,1)
		, [TargetNumber] int, [IndexNumber] int, [RecordNumber] int
		, [QuestionNumber] int, [SubsetNumber] int, [GroupingNumber] int
		, [SelectedChoiceNumber] int
		, [RawScore] float)

	insert into @t ([TargetNumber], [IndexNumber], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber]
		, [SelectedChoiceNumber]
		, [RawScore])
	SELECT @targetNumber as [TargetNumber], rsi.Number as [IndexNumber], sm.RecordNumber,
	q.QuestionNumber, q.SubsetNumber, q.GroupingNumber
	, x.SelectedChoiceNumber
	, x.ChoiceAnswerScore
	FROM  [RecordTarget] rt
		inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
		inner join [dbo].[ScoreConfig] cc on cc.Number = rsi.ConfigNumber
		inner join v_MatchRecord sm on sm.PublishNumber = rt.PublishNumber
			and sm.GroupId = rt.GroupId
			and sm.GroupTeacherId = rt.GroupTeacherId
			and sm.GroupRole = rt.GroupRole
		left outer join RecordTargetLog rtl on rtl.TargetNumber = rt.Number and rtl.RecordNumber = sm.RecordNumber
		inner join v_QuestionUnit q on q.SurveyNumber = cc.PaperNumber
		inner join QuestionScore qs on qs.ConfigNumber = cc.Number and qs.QuestionNumber = q.QuestionNumber
		left outer join (
			select 
				cs.ConfigNumber
				, w.RecordNumber,w.QuestionNumber,w.SubsetNumber,w.GroupingNumber, wv.ChoiceNumber 
				, cs.ChoiceNumber as SelectedChoiceNumber
				, cs.Score as ChoiceAnswerScore
			from RecordRaw w 
				inner join RecordRawValue wv on wv.RawNumber = w.Number
				inner join ChoiceScore cs on cs.ChoiceNumber = wv.ChoiceNumber --and cs.ConfigNumber = qs.ConfigNumber 
		) x on x.ConfigNumber = cc.[Number] and x.RecordNumber = sm.RecordNumber and x.QuestionNumber = q.QuestionNumber and x.SubsetNumber = q.SubsetNumber and x.GroupingNumber = q.GroupingNumber
	where 
		rt.Number = @targetNumber
		and sm.RecordNumber is not null
		and sm.RecordDone = 1
		and qs.Number is not null -- 只查能設定分數的單選題
		and qs.Score >= 0 -- 只存有分數設定的題目
		and rtl.Number is null

	/*
	print '[TargetNumber]'
	print @targetNumber
	*/
	declare @recordCount int
	select @recordCount = count(*) from @t
	
	/*
	print '[RecordCount]'
	print @recordCount
	*/


	insert into [RecordTargetLog] (TargetNumber, RecordNumber)
	select distinct TargetNumber, RecordNumber from @t;

	Insert into [dbo].[RecordQuestionScore] (
		[TargetNumber], [IndexNumber], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber]
		, [SelectedChoiceNumber]
		, [RawScore]
		) 
	select [TargetNumber], [IndexNumber], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber]
		, [SelectedChoiceNumber]
		, [RawScore] 
	from @t;


	--set statistics time off

	/*
	declare @recCount int
	select @recCount = count(*)
	from [RecordQuestionScore] 
	where [TargetNumber] = 

	Insert into [_DebugLog] (Category,DataKey,RecordCount,StartDate,CompleteDate)
	values ('RecordQuestionScore', TargetNumber, @recCount)
	*/
END

/*
---exec sp_RecordQuestionScore_SaveByTarget 20430
	declare @targetNumber int = 20430
	select * from RecordTarget where Number = @targetNumber
	select * from RecordTargetLog where TargetNumber = @targetNumber

	declare @t Table ([Idx] int identity(1,1)
		, [TargetNumber] int, [IndexNumber] int, [RecordNumber] int
		, [QuestionNumber] int, [SubsetNumber] int, [GroupingNumber] int
		, [SelectedChoiceNumber] int
		, [RawScore] float)

--	insert into @t ([TargetNumber], [IndexNumber], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber], [SelectedChoiceNumber], [RawScore])
	SELECT rtl.Number as [RTL], @targetNumber as [TargetNumber], rsi.Number as [IndexNumber], sm.RecordNumber,
	q.QuestionNumber, q.SubsetNumber, q.GroupingNumber
	, x.SelectedChoiceNumber
	, x.ChoiceAnswerScore
	FROM  [RecordTarget] rt
		inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
		inner join [dbo].[ScoreConfig] cc on cc.Number = rsi.ConfigNumber
		--inner join dbo.SurveyPaper p on p.Number = cc.SurveyNumber
		--inner join dbo.PublishSetting ps on ps.Number = cc.PublishNumber -- p.PublishNumber and p.PublishVersion = ps.LastPublishVersion
		inner join v_MatchRecord sm on sm.PublishNumber = rt.PublishNumber --ps.Guid
			and sm.GroupId = rt.GroupId
			and sm.GroupTeacherId = rt.GroupTeacherId
			and sm.GroupRole = rt.GroupRole
		left outer join RecordTargetLog rtl on rtl.TargetNumber = rt.Number and rtl.RecordNumber = sm.RecordNumber
		inner join v_QuestionUnit q on q.SurveyNumber = cc.PaperNumber -- p.Number
		inner join QuestionScore qs on qs.ConfigNumber = cc.Number and qs.QuestionNumber = q.QuestionNumber
		left outer join (
			select 
				cs.ConfigNumber
				, w.RecordNumber,w.QuestionNumber,w.SubsetNumber,w.GroupingNumber, wv.ChoiceNumber 
				, cs.ChoiceNumber as SelectedChoiceNumber
				, cs.Score as ChoiceAnswerScore
			from RecordRaw w 
				inner join RecordRawValue wv on wv.RawNumber = w.Number
				inner join ChoiceScore cs on cs.ChoiceNumber = wv.ChoiceNumber --and cs.ConfigNumber = qs.ConfigNumber 
		) x on x.ConfigNumber = cc.[Number] and x.RecordNumber = sm.RecordNumber and x.QuestionNumber = q.QuestionNumber and x.SubsetNumber = q.SubsetNumber and x.GroupingNumber = q.GroupingNumber
	where 
		rt.Number = @targetNumber
		and sm.RecordNumber is not null
		and sm.RecordDone = 1
		and qs.Number is not null -- 只查能設定分數的單選題
		and qs.Score >= 0 -- 只存有分數設定的題目
		--and rtl.Number is null


	select r.*, w.*, v.* 
	from Record r
	left outer join RecordRaw w on w.RecordNumber = r.Number
	left outer join RecordRawValue v on v.RawNumber = w.Number
	where r.Number = 43371 and w.QuestionNumber = 1226 and w.SubsetNumber = 2812 and w.GroupingNumber = 0
	
	select * from RecordTargetLog where recordnumber = 43371
	select * from Record where number = 43371
	select * from RecordRaw where recordnumber = 43371
	select * from RecordRawValue where number = 43371

	delete from Record where number in (
		select r.Number
		from Record r
		left outer join RecordRaw w on w.RecordNumber = r.Number
		group by r.Number
		having count(w.Number) = 0
	)

	delete RecordTargetLog where number in (
		select rtl.Number 
		from RecordTargetLog rtl
		left outer join Record r on r.Number = rtl.RecordNumber
		where r.Number is null
	)

	select r.Number, count(w.Number)
	from Record r
	left outer join RecordRaw w on w.RecordNumber = r.Number
	group by r.Number
	having count(w.Number) = 0

--select * from @t

*/


/*


select TargetNumber,count(*) as CNT 
from [RecordQuestionScore] group by [TargetNumber]

--select * from RecordTarget
declare @targetNumber int = 1

	SELECT @targetNumber as [TargetNumber], sm.RecordNumber,
	q.QuestionNumber, q.SubsetNumber, q.GroupingNumber
	, x.ChoiceAnswerScore
	, qs.Score as QuestionScoreSetting
	, qs.ItemCount as QuestionItemCount
	FROM [dbo].[ScoreConfig] cc
		--inner join dbo.SurveyPaper p on p.Number = cc.SurveyNumber
		inner join dbo.PublishSetting ps on ps.Number = cc.PublishNumber -- p.PublishNumber and p.PublishVersion = ps.LastPublishVersion
		inner join v_SurveyMatch sm on sm.SurveyId = ps.Guid
		inner join v_QuestionUnit q on q.SurveyNumber = cc.PaperNumber -- p.Number
		inner join (
			select Number, ConfigNumber, QuestionNumber, Score
			, (select count(*) from v_QuestionUnit where QuestionNumber = QuestionScore.QuestionNumber) as ItemCount
			from QuestionScore 
		) qs on qs.QuestionNumber = q.QuestionNumber and qs.ConfigNumber = cc.Number
		left outer join (
			select 
				cs.ConfigNumber
				, w.RecordNumber,w.QuestionNumber,w.SubsetNumber,w.GroupingNumber, wv.ChoiceNumber 
			
				, cs.Score as ChoiceAnswerScore
			from RecordRaw w 
				inner join RecordRawValue wv on wv.RawNumber = w.Number
				inner join ChoiceScore cs on cs.ChoiceNumber = wv.ChoiceNumber --and cs.ConfigNumber = qs.ConfigNumber 
		) x on x.ConfigNumber = cc.[Number] and x.RecordNumber = sm.RecordNumber and x.QuestionNumber = q.QuestionNumber and x.SubsetNumber = q.SubsetNumber and x.GroupingNumber = q.GroupingNumber
	where cc.[Number] = @scoreConfigNumber
		and sm.RecordNumber is not null
		and sm.RecordDone = 1
		and qs.Number is not null -- 只查能設定分數的單選題
		and qs.Score > 0 -- 只存有分數設定的題目

*/