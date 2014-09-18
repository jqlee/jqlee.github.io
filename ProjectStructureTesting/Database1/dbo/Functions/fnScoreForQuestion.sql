-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnScoreForQuestion]
(	
	-- Add the parameters for the function here
	@surveyNumber int = 0
	,@logNumber int = 0
	,@matchKey varchar(100) = null
)
RETURNS TABLE 
AS
RETURN 
(

	select ROW_NUMBER() over(order by q.SortOrder) as RowIndex, x.*
	,qs.Score as QuestionRatio
	,(x.AverageScore*qs.Score/100) as GainScore
	from ScoreLog sl
	inner join QuestionScore qs on qs.ConfigNumber = sl.ConfigNumber
	inner join (
		select QuestionNumber
		, avg(AverageScore) as AverageScore
		, avg(StandardDeviation) as StandardDeviation
		from fnScoreForQuestionArea(@surveyNumber,@logNumber,@matchKey)
		group by QuestionNumber
	) x on x.QuestionNumber = qs.QuestionNumber
	inner join Question q on q.Number = x.QuestionNumber

	where sl.Number = @logNumber



	-- Add the SELECT statement with parameter references here
)
