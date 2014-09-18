-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OutputRaw_GetScoreList]
	-- Add the parameters for the stored procedure here
	@surveyNumber int 
	,@logNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	select mt.MatchName as MatchName,m.Name as MemberName
	,dbo.fn_GetQuestionKey(q.QuestionNumber, isNull(q.SubsetNumber,0), isNull(q.GroupingNumber,0)) as QuestionKey
	,q.AutoId as QuestionId
	,q.FullTitle as QuestionTitle
	,q.AutoId + dbo.fnPadLeft(c.SortOrder,3,'0') as ChoiceId
	,c.[Text] as ChoiceText,w.* 
	from ScoreRaw w
		left outer join dbo.fnTargetMatch(@surveyNumber)  mt on mt.MatchKey = w.MatchKey
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
		) mt on mt.Id = w.MatchKey
*/
		left outer join v_QuestionUnit q on q.QuestionNumber = w.QuestionNumber and q.SubsetNumber = w.SubsetNumber and q.GroupingNumber = w.GroupingNumber
		left outer join v_Choice c on c.Number = w.ChoiceNumber
		inner join v_Member m on m.Id = w.MemberId
	where w.[LogNumber] = @logNumber and w.SurveyNumber = @surveyNumber
	order by w.MatchKey, w.MatchFilter, q.Section, q.SortOrder, m.Id
END
