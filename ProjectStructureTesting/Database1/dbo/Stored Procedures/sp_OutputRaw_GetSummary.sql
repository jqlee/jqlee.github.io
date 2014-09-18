-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OutputRaw_GetSummary]
	-- Add the parameters for the stored procedure here
	@surveyNumber int = 0
	,@memberId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;

	select rV.MatchKey, mt.MatchName, rV.MatchFilter, q.AutoId as QuestionId, q.AutoId + dbo.fnPadLeft(c.SortOrder,3,'0') as ChoiceId
	, q.Section, q.SortOrder, dbo.fn_GetQuestionKey(q.QuestionNumber, isNull(q.SubsetNumber,0), isNull(q.GroupingNumber,0)) as QuestionKey
	,q.Title+isNull(q.SubsetText,'')+isNull(q.GroupingText,'') as [QuestionTitle]
	, c.Number as [ChoiceNumber]
	, c.[Text] as [ChoiceText]
	, case when rv.Total is null then 0 else rv.Total end as [Summary]
	from Survey s
	inner join v_QuestionUnit q on q.SurveyNumber =s.Number
	--left outer join Subset ss on ss.QuestionNumber = q.Number and ss.Dimension = 1
	--left outer join Subset sg on sg.QuestionNumber= q.Number and sg.Dimension = 2
	left outer join v_Choice c on c.QuestionNumber = q.QuestionNumber
	left outer join (
		select r.MatchKey, r.MatchFilter, r.SurveyNumber, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber,v.ChoiceNumber as AnswerNumber
		, count(r.Number) as Total
		 from Record as r
		inner join RecordRaw as w on w.RecordNumber = r.Number
		inner join RecordRawValue as v on v.RawNumber = w.Number
		where r.MemberId = isNull(@memberId,r.MemberId)
		group by r.MatchKey, r.MatchFilter, r.SurveyNumber, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber,v.ChoiceNumber
	) rv on rv.SurveyNumber = s.Number
	and rv.QuestionNumber = q.QuestionNumber 
	and rv.SubsetNumber = isNull(q.SubsetNumber,0)
	and rv.GroupingNumber = isNull(q.GroupingNumber ,0)
	and rv.AnswerNumber = c.Number
	left outer join dbo.fnGetMatchTable(@surveyNumber) mt on mt.MatchKey =  rv.MatchKey
	
	where s.Number = @surveyNumber and c.Number >=0
	order by q.Section, q.QuestionSort, q.SubsetSort, q.GroupingSort, c.SortOrder

END
