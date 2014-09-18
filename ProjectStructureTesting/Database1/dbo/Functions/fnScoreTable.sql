-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnScoreTable] 
(	
	-- Add the parameters for the function here
	@surveyNumber int ,
	@configNumber int 
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	
	select  qs.Score as QuestionScore , cs.Score as ChoiceScore
	 , q.Number as QuestionNumber, q.Title
	, c.Number as ChoiceNumber, c.Text as ChoiceText
	from --v_QuestionUnit q  
	Question q
	inner join QuestionScore qs on qs.QuestionNumber = q.Number and qs.ConfigNumber = @configNumber
	inner join Choice c on c.QuestionNumber = q.Number
	inner join ChoiceScore cs on cs.ChoiceNumber = c.Number and cs.ConfigNumber = @configNumber

	where q.SurveyNumber = @surveyNumber
	--order by q.Section, q.SortOrder, c.SortOrder
)
