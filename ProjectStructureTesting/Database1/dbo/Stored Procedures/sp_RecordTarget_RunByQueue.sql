-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordTarget_RunByQueue]
	-- Add the parameters for the stored procedure here
	--@indexNumber int
	@clearLog bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	update RecordTarget set Done = 0


	-- 先將無紀錄的標記為完成以免浪費時間
	update RecordTarget set Done = 1
	where Number in (
		select rt.Number as TargetNumber
		from RecordTarget rt
		left outer join Record r on r.PublishNumber = rt.PublishNumber and r.GroupId = rt.GroupId and r.GroupTeacherId = rt.GroupTeacherId and r.GroupRole = rt.GroupRole and r.Done = 1
		where rt.Done = 0
		group by rt.Number
		having count(r.Number) = 0
	)
	
	/*
	select rt.Number as TargetNumber, count(r.Number) as RecordCount
	from RecordTarget rt
	left outer join Record r on r.PublishNumber = rt.PublishNumber and r.GroupId = rt.GroupId and r.GroupTeacherId = rt.GroupTeacherId and r.GroupRole = rt.GroupRole and r.Done = 1
	where rt.Done = 0
	group by rt.Number
	having count(r.Number) = 0
	*/

	declare @targetNumber int, @indexNumber int
	--declare @finalScore float, @stdevpScore float

	declare @finalScore float, @stdevpScore float
	declare @completeCount int = 0


	if (exists(select 0 from RecordTarget where Done = 0))
	begin


		select @targetNumber = [Number],@indexNumber = IndexNumber 
		from RecordTarget where Done = 0 order by newid()

		if (@clearLog = 1)
		begin
			delete from RecordTargetLog where TargetNumber = @targetNumber
			delete from RecordQuestionScore where TargetNumber = @targetNumber
		end
		print '@targetNumber:' + convert(varchar, @targetNumber)
		/*	
		*/
		--exec sp_RecordTarget_SaveRecords @targetNumber
		-- 將 SaveRecords 展開
		exec sp_RecordQuestionScore_SaveByTarget @targetNumber

		--begin tran T1

		-- 用存好的RecordQuestionScore計算平均成績與平均標準差
		select @finalScore = Sum(QuestionAverage*Percentage/100)
			,@stdevpScore = sum(QuestionStdevp*Percentage/100)
		from fn_GetTargetScore(@targetNumber)


		-- 由實際作答紀錄統計回收份數與回收率
		/*
		select @completeCount = sum(case when rt.Done = 1 then 1 else 0 end)
		from RecordTarget rt
		inner join Record r on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
		where rt.[Number] = @targetNumber
		*/
		-- 由統計log計算筆數，以反應儲存的資料
		select @completeCount = Count(RecordNumber)
		from RecordTargetLog where TargetNumber = @targetNumber
		/*
		print '@completeCount:'
		print @completeCount
		*/
		--更新RecordTarget
		update RecordTarget
			set Done = 1
				,FinalScore=@finalScore, StdevpScore = @stdevpScore
				,CompleteCount = isNull(@completeCount,0)
				,CompleteRate = Convert(float,case when PublishCount > 0 then Convert(float,isNull(@completeCount,0))/PublishCount else 0 end)
				,LastModified = getdate()
			where Number = @targetNumber
		--commit tran T1	


		-- 檢查作業中索引的項目，如果全都完成，執行該索引的更新作業
		if (not exists(select 0 from RecordTarget where IndexNumber = @indexNumber and Done = 0))
		begin
			exec sp_StatQuestion_SaveReport @indexNumber	
		end

		-- RecordTarget重做過後必須將該項目的Index也重設為0
		--Update RecordScoreIndex set Done = 0 where Number = @indexNumber

		/*
		exec sp_RecordQuestionScore_SaveByTarget @targetNumber
		
		select @finalScore = Sum(AverageScore*QuestionRate/100)
			,@stdevpScore = sum(StdevpScore*QuestionRate/100)
		from fn_GetTargetScore(@targetNumber)

		update RecordTarget
		 set Done = 1,FinalScore=@finalScore, StdevpScore = @stdevpScore
		 where Number = @targetNumber
		*/
	end


END


/*
exec sp_RecordTarget_RunByQueue 


declare @indexGuid uniqueidentifier = '34409c37-3380-49de-9d83-38664a6808fd'
select 
count(rt.Number) as TotalCount
,count(rt.Done) as CompleteCount
from RecordScoreIndex rsi
inner join RecordTarget rt on rt.IndexNumber = rsi.Number
where rsi.Guid = @indexGuid


select * from RecordTarget where PublishNumber = 120 and GroupId = '1001CBNAD2B749000'
select * from RecordTarget where Number = 20062

	select sum(case when rt.Done = 1 then 1 else 0 end)
	from RecordTarget rt
	inner join Record r on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
	where rt.[Number] = 20062

select * from RecordTarget where FinalScore > 0
exec 
20450



Update RecordTarget set Done = 0 where Number = 20269
exec sp_RecordTarget_RunByQueue 

select * from RecordTarget where PublishNumber = 120 and GroupId = '1001CBNAD2B749000'

select * from RecordTargetLog where TargetNumber = 20062
*/