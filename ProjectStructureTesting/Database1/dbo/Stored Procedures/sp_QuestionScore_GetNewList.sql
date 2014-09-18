-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_QuestionScore_GetNewList]
	@surveyNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;

	select 
	convert(bit, case q.OptionDisplayType when 1 then 1 else 0 end) as [AvailableScore],
	@surveyNumber as SurveyNumber,Q.Section as QuestionSection,Q.Title as QuestionTitle, q.Number as QuestionNumber
	, 0 as Number, 0 as ConfigNumber, 0.0 as Score
	, (select count(0) from [Choice] where QuestionNumber = q.Number) as ChoiceCount
	, (select count(0) 
	from Question qq
	left outer join Subset qs on qs.QuestionNumber = qq.Number and qs.Dimension = 1
	left outer join Subset qg on qg.QuestionNumber = qq.Number and qs.Dimension = 2
	where qq.Number = q.Number) as AnswerAreaCount
	from Question q 
	where q.SurveyNumber = @surveyNumber --and q.OptionDisplayType = 1
	order by q.SortOrder

END

