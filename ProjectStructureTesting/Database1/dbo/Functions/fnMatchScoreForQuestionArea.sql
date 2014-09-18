-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnMatchScoreForQuestionArea]
(	
	-- Add the parameters for the function here
	@surveyNumber int
	,@logNumber int
)
RETURNS TABLE 
AS
RETURN 
(
	select r.MatchKey, QuestionNumber, SubsetNumber, GroupingNumber
	, count(sr.Number) as [PickCount]
	, avg(ChoiceScore) as [AverageScore]
	, isNull(stdevp(ChoiceScore),0) as [StandardDeviation] --當只有一筆時，標準差是回傳null而不是0
	from ScoreRaw sr
	inner join Record r on r.Number = sr.RecordNumber
	where sr.SurveyNumber = @surveyNumber and sr.LogNumber = @logNumber
	 and r.Done = 1
	group by r.MatchKey, QuestionNumber, SubsetNumber, GroupingNumber

)

