-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SurveyMatch_GetScoreList
	-- Add the parameters for the stored procedure here
	@scoreConfigNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT cc.[Number] as ScoreConfigNumber
	, qs.Score as QuestionTotalScore
	, x.ChoiceAnswerScore
	, (qs.Score/100 * x.ChoiceAnswerScore) as ChoiceFinalScore
	, q.QuestionNumber, q.GroupingNumber, q.SubsetNumber, q.FullTitle
	, sm.*
	FROM [dbo].[ScoreConfig] cc
		inner join dbo.SurveyPaper p on p.Number = cc.SurveyNumber
		inner join dbo.PublishSetting ps on ps.Number = p.PublishNumber and p.PublishVersion = ps.LastPublishVersion
		inner join v_SurveyMatch sm on sm.SurveyId = ps.Guid
		inner join v_QuestionUnit q on q.SurveyNumber = p.Number
		left outer join QuestionScore qs on qs.QuestionNumber = q.QuestionNumber and qs.ConfigNumber = cc.Number
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
		and qs.Score > 0
	order by q.QuestionSort, q.GroupingSort, q.SubsetSort,sm.MemberId

END
