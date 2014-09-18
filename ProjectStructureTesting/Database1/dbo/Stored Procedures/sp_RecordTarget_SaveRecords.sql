-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	
--    1. 執行RecordQuestionScore存檔
--    2. 利用RecordQuestionScore資料統計成績
--    3. 對RecordTarget更新成績與回收率
-- Update: 
--    本程式已展開至sp_RecordTarget_RunByQueue之中，避免直接呼叫
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordTarget_SaveRecords]
	-- Add the parameters for the stored procedure here
	@targetNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- 執行存檔作業
	exec sp_RecordQuestionScore_SaveByTarget @targetNumber
		

	begin tran T1
	declare @finalScore float, @stdevpScore float
	declare @completeCount int = 0
	-- 用存好的RecordQuestionScore計算平均成績與平均標準差
	select @finalScore = Sum(QuestionAverage*Percentage/100)
		,@stdevpScore = sum(QuestionStdevp*Percentage/100)
	from fn_GetTargetScore(@targetNumber)

	/*
	-- 計算回收份數與回收率
	select @completeCount = sum(case when rt.Done = 1 then 1 else 0 end)
	from RecordTarget rt
	inner join Record r on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
	where rt.[Number] = @targetNumber
	*/

	-- 改由統計log計算筆數，以反應儲存的資料
	select @completeCount = Count(RecordNumber)
	from RecordTargetLog where TargetNumber = @targetNumber

	--更新RecordTarget
	update RecordTarget
		set Done = 1
			,FinalScore=@finalScore, StdevpScore = @stdevpScore
			,CompleteCount = isNull(@completeCount,0)
			,CompleteRate = Convert(float,case when PublishCount > 0 then Convert(float,isNull(@completeCount,0))/PublishCount else 0 end)
		where Number = @targetNumber
	commit tran T1
END

/*
select * from RecordScoreIndex where [Guid] = 'faeed341-023e-4cf0-a376-f13780765688'
select * from RecordTarget where IndexNumber = 186

	declare @targetNumber int = 20262

	declare @completeCount int = 0
	select sum(case when rt.Done = 1 then 1 else 0 end) as [CompleteCount]
	from RecordTarget rt
	inner join Record r on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
	where rt.[Number] = @targetNumber


	select Sum(QuestionAverage*Percentage/100) as [finalScore]
		,sum(QuestionStdevp*Percentage/100) as [stdevpScore]
	from fn_GetTargetScore(@targetNumber)

	select * from RecordTarget where CompleteCount > 0 order by number desc
*/


/*
	declare @targetNumber int = 20262

	declare @finalScore float, @stdevpScore float
	declare @completeCount int = 0

    -- Insert statements for procedure here
	--exec sp_RecordQuestionScore_SaveByTarget @targetNumber
		
	-- 用存好的RecordQuestionScore計算平均成績與平均標準差
	select @finalScore = Sum(QuestionAverage*Percentage/100)
		,@stdevpScore = sum(QuestionStdevp*Percentage/100)
	from fn_GetTargetScore(@targetNumber)

	-- 計算回收份數與回收率
	select @completeCount = sum(case when rt.Done = 1 then 1 else 0 end)
	from RecordTarget rt
	inner join Record r on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
	where rt.[Number] = @targetNumber

	update RecordTarget
		set Done = 1
			,FinalScore=@finalScore, StdevpScore = @stdevpScore
			,CompleteCount = @completeCount
			,CompleteRate = Convert(float,case when PublishCount > 0 then Convert(float,@completeCount)/PublishCount else 0 end)
		where Number = @targetNumber
*/

