-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE sp_StatQuestion_GetPaperList
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier
	,@recordCount int = 10
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	select sq.*
	, q.Title as QuestionTitle--, q.AreaTitle
	, sq.ItemCount as QuestionItemCount -- only for grouping result
	, @recordCount as RecordCount
	, Convert(float,case when @recordCount > 0 then Convert(float,sq.AnswerCount)/@recordCount else 0 end) as AnswerRate
	from RecordScoreIndex rsi
	inner join (
		Select IndexNumber,QuestionNumber
		, count(*) as ItemCount
		, Avg(AnswerCount) as AnswerCount, Avg(AverageScore) as AverageScore, Avg(StdevpScore) as StdevpScore
		from StatQuestion sq
		group by IndexNumber,QuestionNumber
	) sq on sq.IndexNumber = rsi.Number
	inner join Question q on q.Number = sq.QuestionNumber-- and q.SubsetNumber = sq.SubsetNumber and q.GroupingNumber = sq.GroupingNumber
	where rsi.[Guid] = @indexGuid
	order by q.SortOrder

END
