-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create FUNCTION [dbo].[del_fnLoggedQuestionStat]
(	
	-- Add the parameters for the function here
	@logNumber int =0
	,@questionNumber int = 0
	,@subsetNumber int = 0
	,@groupingNumber int = 0
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	
select r.MatchKey,w.QuestionNumber,w.SubsetNumber,w.GroupingNumber,w.ChoiceNumber,count(*) as CHooseCount
from ScoreRaw w
inner join Record r on r.Number = w.RecordNumber
where w.LogNumber = @logNumber and w.QuestionNumber = @questionNumber and w.SubsetNumber = @subsetNumber and w.GroupingNumber = @groupingNumber
group by r.MatchKey,w.QuestionNumber,w.SubsetNumber,w.GroupingNumber,w.ChoiceNumber
/*
	select r.MatchKey, r.MatchFilter, q.Section, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber, v.ChoiceNumber
	 ,count(v.Number) as [ChooseCount]
	from Record r
	--inner join RecordMatch rm on rm.RecordNumber = r.Number
	--inner join RecordRaw w on w.RecordNumber = r.Number
	inner join ScoreRaw w on w.RecordNumber = r.Number
	

	inner join Question q on q.Number = w.QuestionNumber
	inner join RecordRawValue v on v.RawNumber = w.Number
	where --r.SurveyNumber = @surveyNumber
	w.Number = @logNumber 
	and w.QuestionNumber = @questionNumber and w.SubsetNumber = @subsetNumber and w.GroupingNumber = @groupingNumber
	group by r.MatchKey, r.MatchFilter,q.Section,w.QuestionNumber, w.SubsetNumber, w.GroupingNumber, v.ChoiceNumber
	*/
)