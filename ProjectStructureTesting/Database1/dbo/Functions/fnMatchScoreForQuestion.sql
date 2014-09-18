-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnMatchScoreForQuestion]
(	
	-- Add the parameters for the function here
	@surveyNumber int = 0
	,@logNumber int = 0
)
RETURNS TABLE 
AS
RETURN 
(
	select x.*
	,qs.Score as QuestionRatio
	,(x.AverageScore*qs.Score/100) as GainScore
	from ScoreLog sl
	inner join QuestionScore qs on qs.ConfigNumber = sl.ConfigNumber
	left outer join (
		select MatchKey, QuestionNumber
		, avg(AverageScore) as AverageScore
		, avg(StandardDeviation) as StandardDeviation
		from fnMatchScoreForQuestionArea(@surveyNumber,@logNumber)
		group by MatchKey,QuestionNumber
	) x on x.QuestionNumber = qs.QuestionNumber
	where sl.Number = @logNumber



	-- Add the SELECT statement with parameter references here
)
