/* for Admin*/
CREATE PROCEDURE [dbo].[sp_Survey_GetListWithCount]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT s.*, isNull(r.[Count], 0) as RecordCount, isNull(q.[Count], 0) as QuestionCount
	FROM [dbo].[Survey] s
	left outer join ( Select SurveyNumber, count(Number) as [Count] 
		from Record 
		group by SurveyNumber) as r on r.SurveyNumber = s.Number
	left outer join ( Select SurveyNumber, count(Number) as [Count]
		from Question 
		group by SurveyNumber) as q on q.SurveyNumber = s.Number
	order by s.Number

END

