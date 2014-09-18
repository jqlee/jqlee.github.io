-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OutputRaw_GetList]
	-- Add the parameters for the stored procedure here
	@surveyNumber int = 0
	,@memberId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;

	--取回某份問卷的作答原始資料
		select rv.MatchKey, mt.MatchName, rv.MatchFilter,q.AutoId as QuestionId, q.AutoId + dbo.fnPadLeft(c.SortOrder,3,'0') as ChoiceId
	,q.Section, dbo.fn_GetQuestionKey(q.QuestionNumber, isNull(q.SubsetNumber,0), isNull(q.GroupingNumber,0)) as QuestionKey
	,q.Title+' '+isNull(q.SubsetText,'')+' '+isNull(q.GroupingText,'') as [QuestionTitle]
	--, q.Title as [QuestionTitle], ss.[Text] as [Subset], sg.[Text] as [Grouping]
	, c.[Text] as [ChoiceText]
	,rv.RecordNumber,rv.MemberId,rv.MemberName
	, case when rv.AnswerNumber >0 then null else rv.AnswerText end as [AnswerText]
	from Survey s
	inner join v_QuestionUnit q on q.SurveyNumber =s.Number
	inner join 	v_Choice c on c.QuestionNumber = q.QuestionNumber
	inner join (
		select r.MatchKey, r.MatchFilter, r.Number as RecordNumber, r.MemberId, r.MemberName, r.SurveyNumber, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber
		,isNull(v.ChoiceNumber,-2) as [AnswerNumber], w.AnswerText
		 from Record as r
		inner join RecordRaw as w on w.RecordNumber = r.Number
		left outer join RecordRawValue as v on v.RawNumber = w.Number
		where r.MemberId = isNull(@memberId,r.MemberId)
	) rv on rv.SurveyNumber = s.Number
		and rv.QuestionNumber = q.QuestionNumber 
		and rv.SubsetNumber = isNull(q.SubsetNumber,0) 
		and rv.GroupingNumber = isNull(q.GroupingNumber,0)
		and (rv.AnswerNumber = c.Number)
	left outer join dbo.fnGetMatchTable(@surveyNumber) mt on mt.MatchKey =  rv.MatchKey

	where s.Number = @surveyNumber --and w.QuestionNumber = 219
	order by q.Section, q.SortOrder, q.SubsetSort, q.GroupingSort, c.SortOrder
	
	/*
	select rv.MatchKey, rv.MatchFilter,q.AutoId as QuestionId, q.AutoId + dbo.fnPadLeft(c.SortOrder,3,'0') as ChoiceId
	,q.Section, dbo.fn_GetQuestionKey(q.QuestionNumber, isNull(q.SubsetNumber,0), isNull(q.GroupingNumber,0)) as QuestionKey
	,q.Title+' '+isNull(q.SubsetText,'')+' '+isNull(q.GroupingText,'') as [QuestionTitle]
	--, q.Title as [QuestionTitle], ss.[Text] as [Subset], sg.[Text] as [Grouping]
	, c.[Text] as [ChoiceText]
	,rv.RecordNumber,rv.MemberId,rv.MemberName
	, case when rv.AnswerNumber >0 then null else rv.AnswerText end as [AnswerText]
	from Survey s
	inner join v_QuestionUnit q on q.SurveyNumber =s.Number
	inner join 	v_Choice c on c.QuestionNumber = q.QuestionNumber
	inner join (
		select r.MatchKey, r.MatchFilter,r.Number as RecordNumber, r.MemberId, r.MemberName, r.SurveyNumber, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber
		,isNull(v.ChoiceNumber,-2) as [AnswerNumber], w.AnswerText
		 from Record as r
		inner join RecordRaw as w on w.RecordNumber = r.Number
		left outer join RecordRawValue as v on v.RawNumber = w.Number
		where r.MemberId = isNull(@memberId,r.MemberId)
	) rv on rv.SurveyNumber = s.Number
		and rv.QuestionNumber = q.QuestionNumber 
		and rv.SubsetNumber = isNull(q.SubsetNumber,0) 
		and rv.GroupingNumber = isNull(q.GroupingNumber,0)
		and (rv.AnswerNumber = c.Number)

	where s.Number = @surveyNumber --and w.QuestionNumber = 219
	order by q.Section, q.SortOrder, q.SubsetSort, q.GroupingSort, c.SortOrder
	*/
END
