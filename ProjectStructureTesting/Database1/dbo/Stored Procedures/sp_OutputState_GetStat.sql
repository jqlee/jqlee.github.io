-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OutputState_GetStat]
	-- Add the parameters for the stored procedure here
	@surveyNumber int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	
	select 
		r.MatchKey,mt.MatchName as MatchName, r.MatchFilter
		,r.SelectedCount
		--,isNull(r.AvgScore,0) as [AvgScore], isNull(r.StdScore,0) as [StdScore]
		,q.QuestionNumber--,c.Number as ChoiceNumber
		,q.AutoId as QuestionId
		--, q.AutoId + dbo.fnPadLeft(c.SortOrder,3,'0') as ChoiceId
		,q.SurveyNumber, dbo.fn_GetQuestionKey(q.QuestionNumber, isNull(q.SubsetNumber,0), isNull(q.GroupingNumber,0)) as QuestionKey
		,q.FullTitle as QuestionTitle
		--, c.[Text] as ChoiceText
	from v_QuestionUnit q 

	--inner join Choice c on c.QuestionNumber = q.QuestionNumber
	left outer join (
		select MatchKey,MatchFilter,QuestionNumber, SubsetNumber,GroupingNumber--,ChoiceNumber
		,count(ChoiceNumber) as SelectedCount
		from ScoreRaw
		group by MatchKey,MatchFilter,QuestionNumber, SubsetNumber,GroupingNumber--,ChoiceNumber
	) r on r.QuestionNumber = q.QuestionNumber and r.SubsetNumber = q.SubsetNumber and r.GroupingNumber = q.GroupingNumber --and r.ChoiceNumber = c.Number
	left outer join dbo.fnTargetMatch(@surveyNumber)  mt on mt.MatchKey = r.MatchKey
/*
	left outer join (
		Select distinct d.Id , d.Name
		from Survey s 
		inner join TargetForDepartment t on t.SurveyNumber = s.Number
		--inner join v_Member m on m.DepartmentId = t.DepartmentId and m.Grade = isNull(t.MemberGrade,m.Grade)
		inner join v_Department d on d.Id =  isNull(t.DepartmentId,d.Id)
		where s.Number = @surveyNumber and t.TargetMark = 3
		union
		Select distinct g.Id , g.Name
		from Survey s 
		inner join TargetForDepartment t on t.SurveyNumber = s.Number
		inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId) and g.GroupYear = isNull(t.GroupYear,g.GroupYear)
		where s.Number = @surveyNumber and t.TargetMark = 4
	) m on m.Id = r.MatchKey
*/
	where q.SurveyNumber = @surveyNumber
	order by 
	--,c.SortOrder
	r.MatchKey,r.MatchFilter,q.Section, q.SortOrder


END
