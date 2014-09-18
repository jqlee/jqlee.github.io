
CREATE PROCEDURE [dbo].[sp_Question_GetListForScore]
	@paperGuid uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	SELECT a.AnswerAreaCount, q.*
	FROM [dbo].[Question] q
	inner join [dbo].[SurveyPaper] p on p.Number = q.SurveyNumber
	inner join (
		SELECT q.QuestionNumber,count(*) as AnswerAreaCount
			FROM [dbo].[v_QuestionUnit] q
			inner join [dbo].[SurveyPaper] p on p.Number = q.SurveyNumber
			where p.[Guid] = @paperGuid and q.CanScore = 1
			group by q.QuestionNumber
	) a on a.QuestionNumber = q.Number
	where p.[Guid] = @paperGuid and q.OptionDisplayType = 1 and OptionMultipleSelection = 0
	order by q.SortOrder
END