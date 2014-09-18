-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_StatQuestion_GetList
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
	, q.Title as QuestionTitle, q.AreaTitle
	, @recordCount as RecordCount
	, Convert(float,case when @recordCount > 0 then Convert(float,sq.AnswerCount)/@recordCount else 0 end) as AnswerRate
	from StatQuestion sq
	inner join RecordScoreIndex rsi on rsi.Number = sq.IndexNumber
	inner join v_QuestionUnit q on q.QuestionNumber = sq.QuestionNumber and q.SubsetNumber = sq.SubsetNumber and q.GroupingNumber = sq.GroupingNumber
	where rsi.[Guid] = @indexGuid
	
END
