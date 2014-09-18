-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnCurrentRaw]
(	
	-- Add the parameters for the function here
	@surveyNumber int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	
	select r.Number as RecordNumber, r.TargetNumber, r.MatchKey, r.MatchFilter
	--, q.Section
	, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber, v.ChoiceNumber
	 ,v.Number as ValueNumber, r.MemberId
	 ,r.Done as RecordDone
	from Record r
	--inner join RecordMatch rm on rm.RecordNumber = r.Number
	inner join RecordRaw w on w.RecordNumber = r.Number
	--inner join Question q on q.Number = w.QuestionNumber
	inner join RecordRawValue v on v.RawNumber = w.Number
	where r.SurveyNumber = @surveyNumber
	--group by r.MatchKey, r.MatchFilter,q.Section,w.QuestionNumber, w.SubsetNumber, w.GroupingNumber, v.ChoiceNumber

)
