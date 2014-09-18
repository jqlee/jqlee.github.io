-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_ListMatchScore]
(	
	-- Add the parameters for the function here
	@surveyNumber int
	,@logNumber int
)
RETURNS TABLE 
AS
RETURN 
(

	select MatchKey
	,avg([QuestionAverageScore]) as AverageScore
	,avg([QuestionStandardDeviation]) as StandardDeviation
	from fn_ListQuestionScore(@surveyNumber,@logNumber) 
	group by MatchKey
)
