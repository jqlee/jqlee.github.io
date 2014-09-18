-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnScoreForQuestionArea]
(	
	-- Add the parameters for the function here
	@surveyNumber int
	,@logNumber int
	,@matchKey varchar(100) = null
)
RETURNS TABLE 
AS
RETURN 
(
	select QuestionNumber, SubsetNumber, GroupingNumber
	, count(sr.Number) as [PickCount]
	, avg(ChoiceScore) as [AverageScore]
	, isNull(stdev(ChoiceScore),0) as [StandardDeviation] --當只有一筆時，標準差是回傳null而不是0
	from ScoreRaw sr
	inner join Record r on r.Number = sr.RecordNumber
	where sr.SurveyNumber = @surveyNumber and sr.LogNumber = @logNumber
	 and r.MatchKey = isNull(@matchKey,r.MatchKey)
	 and r.Done = 1
	group by QuestionNumber, SubsetNumber, GroupingNumber

)
