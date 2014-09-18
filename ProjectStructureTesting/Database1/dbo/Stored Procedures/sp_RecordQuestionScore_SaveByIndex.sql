-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_RecordQuestionScore_SaveByIndex
	-- Add the parameters for the stored procedure here
	@indexNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @scoreConfigNumber int
	select @scoreConfigNumber = ConfigNumber from RecordScoreIndex where Number = @indexNumber
	
    -- Insert statements for procedure here
	-- 保存答題紀錄
	Delete from [RecordQuestionScore] where [IndexNumber] = @indexNumber;

	SET NOCOUNT Off;

	Insert into [dbo].[RecordQuestionScore] ([IndexNumber], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber], [RawScore], [QuestionScoreSetting], [QuestionItemCount]) 
	SELECT @indexNumber as [IndexNumber], sm.RecordNumber,
	q.QuestionNumber, q.SubsetNumber, q.GroupingNumber
	, x.ChoiceAnswerScore
	, qs.Score as QuestionScoreSetting
	, qs.ItemCount as QuestionItemCount
	/*
	, sum(x.ChoiceAnswerScore) as RawScore
	, sum(qs.Score/100) as QuestionRate
	, sum(qs.ItemCount) as ItemCount
	, sum(x.ChoiceAnswerScore * qs.Score/qs.ItemCount/100) as Score
	*/
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


END
