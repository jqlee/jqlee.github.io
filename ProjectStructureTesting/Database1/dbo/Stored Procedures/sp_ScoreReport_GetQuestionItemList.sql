-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_ScoreReport_GetQuestionItemList
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier 
	,@recordCount int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @publishNumber int = 0
	,@ConfigNumber int = 0;

	select @ConfigNumber = sc.Number, @publishNumber = sc.PublishNumber
	from RecordScoreIndex rsi
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	where rsi.[Guid] = @indexGuid;

	select q.Title as QuestionTitle,Q.AreaTitle, @ConfigNumber as ConfigNumber
	, x.* 
	,@recordCount as RecordCount
	,(case when @recordCount>0 then Convert(float,AnswerCount)/@recordCount else 0 end) as AnswerRate
	from PublishSetting ps
	inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	inner join v_QuestionUnit q on q.SurveyNumber = p.Number
	left outer join (
		select w.QuestionNumber, w.SubsetNumber, w.GroupingNumber
		, count(distinct r.Number) as AnswerCount --, rqs.SelectedChoiceNumber
		, Avg(rqs.RawScore) as GainAverage
		, STDEVP(rqs.RawScore) as GainStdevp
		from Record r 
		inner join RecordRaw w on w.RecordNumber = r.Number
		inner join RecordRawValue v on v.RawNumber = w.Number
		left outer join RecordQuestionScore rqs on rqs.RecordNumber = r.Number and rqs.QuestionNumber = w.QuestionNumber and rqs.SubsetNumber = w.SubsetNumber and rqs.GroupingNumber = w.GroupingNumber
		where r.PublishNumber = @publishNumber and r.Done = 1
		group by w.QuestionNumber, w.SubsetNumber, w.GroupingNumber
	) x on x.QuestionNumber = q.QuestionNumber and x.SubsetNumber = q.SubsetNumber and x.GroupingNumber = q.GroupingNumber
	where ps.Number = @publishNumber
	order by q.QuestionSort,q.SubsetSort, q.GroupingSort
	
END
