-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	
-- 1. 儲存科目資料到 RecordTarget，RecordTarget 就是將來的 Queue，RecordTarget.Done用來反應Queue的狀態
-- 2. 當發布完後會根據試卷內的配分設定每個配分各叫用一次，
-- 3. 當發布後，手動建立配分時，會再叫用一次
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_SaveScore_CreateQueue]
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier = null -- indexGuid
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	begin tran T1

	declare @indexNumber int,@scoreConfigNumber int, @publishNumber int, @recordCount int;

	
	select @indexNumber = rsi.[Number], @scoreConfigNumber = rsi.[ConfigNumber]
	from RecordScoreIndex rsi
	where rsi.[Guid] = @indexGuid

	--update index
	update RecordScoreIndex set [Enabled] = 1, [Created] = getdate() 
	--,[RecordCount]=@recordCount 
	where [Number] = @indexNumber

	-- 建RecordTarget，存筆數
	exec sp_RecordTarget_SaveByIndex @indexNumber

	update RecordTarget 
		set [CompleteRate] = case 
			when PublishCount > 0 then (Convert(float,[CompleteCount]) / [PublishCount]) 
			else 0 end
	--update RecordTarget set [CompleteRate] = (Convert(float,[CompleteCount]) / [PublishCount]) 
	where [IndexNumber] = @indexNumber

	select @recordCount = sum(CompleteCount) from RecordTarget where IndexNumber = @indexNumber


	-- 20140507 加入，再一次將紀錄的結果進行統計，依照問卷配分為單位(ScoreConfig與RecordScoreIndex是一對一關係)，將所有提目的結果儲存起來。
	-- 之後教務人員查看整份結果將由此取出，能大幅提高顯示效率
	exec sp_StatQuestion_SaveReport @indexNumber

	update RecordScoreIndex
	set [Done] = 1, [RecordCount]=@recordCount 
	where [Number] = @indexNumber


	-- 以下執行程序會依序跑完符合index，並且Done = 0的target( sp_RecordTarget_SaveRecords @targetNumber)
	--exec sp_RecordTarget_RunByIndex @indexNumber

	/*
	-- 保存統計紀錄
	-- 總分要依靠細項算上來，所以要擺後面
	exec sp_RecordTarget_SaveByIndex @indexNumber=@indexNumber

	-- 保存答題紀錄
	exec sp_RecordQuestionScore_SaveByIndex @indexNumber=@indexNumber

	*/

	commit tran T1
END
