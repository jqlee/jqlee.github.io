-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnMatchScoreForSurvey]
(	
	-- Add the parameters for the function here
	@surveyNumber int = 0
	,@logNumber int = 0
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select @surveyNumber as [SurveyNumber], @logNumber as [LogNumber], [MatchKey]
	, sum(GainScore) as SurveyScore
	, avg(StandardDeviation) as AverageScoreOfStandardDeviation
	, (select sum(qs.Score) from ScoreLog sl inner join QuestionScore qs on qs.ConfigNumber = sl.ConfigNumber
		where sl.Number = @logNumber) as TotalQuestionRatio
	from fnMatchScoreForQuestion(@surveyNumber,@logNumber) x
	group by [MatchKey]
)
