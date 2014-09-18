-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_QuestionUnit_GetListForRecord
	-- Add the parameters for the stored procedure here
	@publishNumber int
	,@canScore bit = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select q.*
	, (select count(*) 
		from RecordRaw w 
		inner join RecordRawText wt on wt.RawNumber = w.Number
		where w.QuestionNumber = q.QuestionNumber and w.QuestionNumber = q.QuestionNumber and w.SubsetNumber = q.SubsetNumber and w.GroupingNumber = q.GroupingNumber
		) as RecordCount
	from PublishSetting ps
	inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	inner join v_QuestionUnit q on q.SurveyNumber = p.Number and q.SurveyNumber = p.Number
	where ps.Number = @publishNumber 
	and 1 = case when @canScore is null then 1 when q.CanScore = @canScore then 1 else 0 end
	order by q.SortOrder, q.SubsetSort, q.GroupingSort

END
