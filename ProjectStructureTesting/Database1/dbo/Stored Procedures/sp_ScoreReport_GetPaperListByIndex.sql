-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_ScoreReport_GetPaperListByIndex
	-- Add the parameters for the stored procedure here
@indexGuid uniqueidentifier 
,@publishCount int = 0
,@recordCount int = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	select @publishCount as PublishCount
	,@recordCount as RecordCount
	, convert(float, case when @publishCount > 0 then convert(float,@recordCount)/@publishCount else 0 end) as ReceiveRate
	,sum((qs.Score/100)*QuestionFinal) as FinalScore
	, sum((qs.Score/100)*QuestionStdevp) as StdevpScore
	from (
		select x.ConfigNumber , x.QuestionNumber
			, Avg(GainAverage) as QuestionFinal
			, Avg(GainStdevp) as QuestionStdevp
			from (
			select rsi.ConfigNumber, rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber
			, count(distinct rqs.RecordNumber) as AnswerCount
			, Convert(float, count(distinct rqs.RecordNumber))/@recordCount as QuestionAnswerRate
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
	inner join QuestionScore qs on qs.ConfigNumber = x.ConfigNumber and qs.QuestionNumber = x.QuestionNumber

END
