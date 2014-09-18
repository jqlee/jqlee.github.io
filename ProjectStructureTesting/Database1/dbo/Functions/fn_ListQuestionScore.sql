-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_ListQuestionScore]
(	
	-- Add the parameters for the function here
	@surveyNumber int
	,@logNumber int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select r.MatchKey, sr.QuestionNumber, sr.GroupingNumber, sr.SubsetNumber
	, avg(sr.ChoiceScore) as [QuestionAverageScore]
	, isNull(stdev(sr.ChoiceScore),0) as [QuestionStandardDeviation]
	from ScoreRaw sr
	inner join Record r on r.Number = sr.RecordNumber
	where  sr.SurveyNumber = @surveyNumber and sr.LogNumber = @logNumber
	group by  r.MatchKey, sr.QuestionNumber, sr.GroupingNumber, sr.SubsetNumber

)
