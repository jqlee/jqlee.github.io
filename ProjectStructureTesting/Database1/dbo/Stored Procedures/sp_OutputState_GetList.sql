-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_OutputState_GetList
	-- Add the parameters for the stored procedure here
	@surveyNumber int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select @surveyNumber as [SurveyNumber],tm.TargetNumber, tm.MatchKey, tm.MatchFilter, tm.MatchName
	,q.AutoId as QuestionId
	, dbo.fn_GetQuestionKey(q.QuestionNumber, isNull(q.SubsetNumber,0), isNull(q.GroupingNumber,0)) as QuestionKey
	,q.QuestionNumber,q.Section, q.SubsetNumber,q.GroupingNumber
	,q.FullTitle as QuestionTitle
	,dbo.fnPadLeft(c.SortOrder,3,'0') as ChoiceId
	,c.Number as ChoiceNumber,c.[Text] as ChoiceText
	,isNull(x.SelectedCount,0) as SelectedCount
	 from v_QuestionUnit q
	inner join dbo.fnTargetMatch(@surveyNumber) tm on tm.SurveyNumber = q.SurveyNumber
	inner join v_Choice c on c.QuestionNumber = q.QuestionNumber
	left outer join (
		select r.MatchKey, r.MatchFilter, w.QuestionNumber,w.SubsetNumber, w.GroupingNumber
		,v.ChoiceNumber , count(v.Number) as SelectedCount
		from Record r 
		inner join RecordRaw w on w.RecordNumber = r.Number
		inner join RecordRawValue v on v.RawNumber = w.Number
		where r.SurveyNumber = @surveyNumber
		group by r.MatchKey, r.MatchFilter, w.QuestionNumber,w.SubsetNumber, w.GroupingNumber,v.ChoiceNumber
	) x on x.MatchKey = tm.MatchKey and x.MatchFilter = tm.MatchFilter
	 and x.QuestionNumber = q.QuestionNumber and x.SubsetNumber = q.SubsetNumber and x.GroupingNumber = q.GroupingNumber
	 and x.ChoiceNumber = c.Number
	where q.SurveyNumber= @surveyNumber 
	-- and q.QuestionNumber=380 and q.SubsetNumber = 1161 and q.GroupingNumber = 0 
	--and tm.MatchKey = '921CMNAU1070000'

	order by tm.[Index], q.Section, q.SortOrder, c.SortOrder

END
