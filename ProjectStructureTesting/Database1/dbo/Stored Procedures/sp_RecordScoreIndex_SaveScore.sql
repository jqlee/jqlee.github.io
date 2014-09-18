-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_SaveScore]
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier = null -- indexGuid
	--,@configGuid uniqueidentifier = null -- indexGuid
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 分別計算題目得分與整份得分

	-- 20140331 增加 GroupSubjectKey 到 Record 表，因此可直接將存檔紀錄 join Record 查出科目平均 

	begin tran T1

	declare @indexNumber int,@scoreConfigNumber int, @publishNumber int, @recordCount int;

	
	select @indexNumber = rsi.[Number], @scoreConfigNumber = rsi.[ConfigNumber]
	from RecordScoreIndex rsi
	where rsi.[Guid] = @indexGuid
	/*
	select @indexNumber = rsi.Number, @publishNumber = sc.PublishNumber, @scoreConfigNumber = sc.Number
	from ScoreConfig sc
	inner join RecordScoreIndex rsi on rsi.ConfigNumber = sc.Number
	where sc.[Guid] = @configGuid
	*/
	/*
	select @recordCount = count(r.Number)
	FROM [dbo].[RecordScoreIndex] rsi
		inner join [dbo].[ScoreConfig] cc on cc.Number = rsi.ConfigNumber
		--inner join dbo.SurveyPaper p on p.Number = cc.SurveyNumber
		inner join dbo.PublishSetting ps on ps.Number = cc.PublishNumber --and p.PublishVersion = ps.LastPublishVersion
		inner join dbo.Record r on r.PublishNumber = ps.Number
	where rsi.[Guid] = @indexGuid and r.Done = 1
	*/

	--update index
	update RecordScoreIndex set [Enabled] = 1, [Created] = getdate() 
	--,[RecordCount]=@recordCount 
	where [Number] = @indexNumber

	-- 建RecordTarget，存筆數
	exec sp_RecordTarget_SaveByIndex @indexNumber

	update RecordTarget set [CompleteRate] = case when PublishCount > 0 then (Convert(float,[CompleteCount]) / [PublishCount]) else 0 end
	--update RecordTarget set [CompleteRate] = (Convert(float,[CompleteCount]) / [PublishCount]) 
	where [IndexNumber] = @indexNumber

	select @recordCount = sum(CompleteCount) from RecordTarget where IndexNumber = @indexNumber

	update RecordScoreIndex
	set [Done] = 1, [RecordCount]=@recordCount 
	where [Number] = @indexNumber


	-- 以下執行程序會依序跑完符合index，並且Done = 0的target( sp_RecordTarget_SaveRecords @targetNumber)
	exec sp_RecordTarget_RunByIndex @indexNumber

	/*
	-- 保存統計紀錄
	-- 總分要依靠細項算上來，所以要擺後面
	exec sp_RecordTarget_SaveByIndex @indexNumber=@indexNumber

	-- 保存答題紀錄
	exec sp_RecordQuestionScore_SaveByIndex @indexNumber=@indexNumber

	*/

	commit tran T1

	--group by sm.RecordNumber, cc.[Number],q.QuestionNumber, q.GroupingNumber, q.SubsetNumber
	
	--SET NOCOUNT ON;
END


/*
將原本整批寫入拆分成三層，以利之後增加進度控制
儲存紀錄的完整流程 
1. 首先用guid建立 index
2. 執行 sp_RecordScoreIndex_SaveScore @indexGuid
	a. 計算筆數、更新index狀態
	b. 執行 sp_RecordTarget_RunByIndex @indexNumber
		建立 Target，計算筆數
		1. 跑迴圈執行 sp_RecordTarget_SaveRecords @targetNumber
			1. 執行sp_RecordQuestionScore_SaveByTarget @targetNumber 儲存資料
			2. 根據存檔紀錄計算成績，寫回RecordTarget



select * from RecordScoreIndex where [Guid] = 'fd3aee9b-8119-4583-b771-ea95306e7808'
select sum(CompleteCount) from RecordTarget where IndexNumber = 134

-- RecordSaveScore.aspx?guid=fd3aee9b-8119-4583-b771-ea95306e7808
declare @indexGuid uniqueidentifier = 'fd3aee9b-8119-4583-b771-ea95306e7808'
--exec sp_RecordScoreIndex_SaveScore @indexGuid
	declare @indexNumber int,@scoreConfigNumber int, @publishNumber int, @recordCount int;

	select @indexNumber = [Number], @scoreConfigNumber = [ConfigNumber]
	from RecordScoreIndex
	where [Guid] = @indexGuid

	print @indexNumber 

	select @recordCount = count(r.Number)
	FROM [dbo].[RecordScoreIndex] rsi
		inner join [dbo].[ScoreConfig] cc on cc.Number = rsi.ConfigNumber
		--inner join dbo.SurveyPaper p on p.Number = cc.SurveyNumber
		inner join dbo.PublishSetting ps on ps.Number = cc.PublishNumber --and p.PublishVersion = ps.LastPublishVersion
		inner join dbo.Record r on r.PublishNumber = ps.Number
	where rsi.[Guid] = @indexGuid and r.Done = 1


	--update index
	update RecordScoreIndex set [Enabled] = 1, [Created] = getdate(),[RecordCount]=@recordCount where [Number] = @indexNumber

	-- 建RecordTarget，存筆數
	exec sp_RecordTarget_SaveByIndex @indexNumber

	update RecordTarget set [CompleteRate] = [CompleteCount] / [PublishCount] where [IndexNumber] = @indexNumber

	-- 以下執行程序會依序跑完符合index，並且Done = 0的target( sp_RecordTarget_SaveRecords @targetNumber)
	exec sp_RecordTarget_RunByIndex @indexNumber




delete from RecordTarget where IndexNumber = 134
-- exec sp_RecordTarget_SaveByIndex 134
update RecordTarget set [CompleteRate] = Convert(float,[CompleteCount]) / [PublishCount] where [IndexNumber] = 134
select * from RecordTarget where IndexNumber = 134
exec sp_RecordTarget_RunByIndex 134
*/