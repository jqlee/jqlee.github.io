-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AnswerLog_GetChoiceCountList] 
	-- Add the parameters for the stored procedure here
	@targetNumber int = 89
	--,@groupId varchar(20) = null, @groupTeacherId varchar(20) = null, @groupRole varchar(20) = null
	--,@memberDepartmentId varchar(20) = null, @memberGrade tinyint = 0, @memberRole varchar(20) = null
	,@questionNumber int = 1033, @subsetNumber int = 0, @groupingNumber int = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



	declare @configNumber int
	select @configNumber = rsi.ConfigNumber from RecordTarget rt 
	inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
	where rt.Number = @targetNumber

	select c.Text as [ChoiceText],cs.Score as [ChoiceScore], isNull(r.SelectedCount,0) as [AnswerCount]
	from Choice c 
	inner join ChoiceScore cs on cs.ChoiceNumber = c.Number
	left outer join (
		select rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber, rqs.SelectedChoiceNumber,count(*) as SelectedCount
		from RecordTarget rt
		inner join RecordQuestionScore rqs on rqs.TargetNumber = rt.Number
		where rt.Number = @targetNumber and rqs.SelectedChoiceNumber is not null
		and rqs.QuestionNumber = @questionNumber and  rqs.SubsetNumber = @subsetNumber and rqs.GroupingNumber = @groupingNumber
		group by rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber, rqs.SelectedChoiceNumber
	) r on r.SelectedChoiceNumber = c.Number
	where c.QuestionNumber = @questionNumber and cs.ConfigNumber = @configNumber
	order by c.SortOrder
	/*

	if (@memberGrade=0) set @memberGrade = null;

	select c.ChoiceNumber, c.ChoiceText
	 ,isNull( x.AnswerCount, 0) as AnswerCount
	from (
		select QuestionNumber, Number as ChoiceNumber, [Text] as ChoiceText, SortOrder
		from Choice c
		where QuestionNumber = @questionNumber
		union
		select @questionNumber as QuestionNumber, 0 as ChoiceNumber, OptionOtherLabel as ChoiceText, 99999 as SortOrder
		from Question where Number = @questionNumber and OptionShowOther = 1
	) c
	left outer join (
		select w.QuestionNumber,w.SubsetNumber, w.GroupingNumber, v.ChoiceNumber, count(v.ChoiceNumber) as AnswerCount
		from fn_GetFilteredRecords(@publishNumber, @groupId, @groupTeacherId, @groupRole, @memberDepartmentId, @memberGrade, @memberRole) FR
		inner join Record r on r.Number = FR.RecordNumber
		inner join RecordRaw w on w.RecordNumber = r.Number
		inner join RecordRawValue v on v.RawNumber = w.Number
		where r.Done=1 and w.QuestionNumber = @questionNumber and w.SubsetNumber = @subsetNumber and w.GroupingNumber = @groupingNumber
		and r.[GroupId] = isNull(@groupId, r.[GroupId])
		and r.[GroupRole] = isNull(@groupRole, r.[GroupRole])
		and r.[GroupTeacherId] = isNull(@groupTeacherId, r.[GroupTeacherId])
		group by w.QuestionNumber,w.SubsetNumber, w.GroupingNumber, v.ChoiceNumber
	) x on x.ChoiceNumber = c.ChoiceNumber and x.QuestionNumber = c.QuestionNumber
	where c.QuestionNumber = @questionNumber
	order by c.SortOrder
	*/
END

/*

declare @targetNumber int = 7019
,@questionNumber int = 1098, @subsetNumber int = 2461, @groupingNumber int = 0

declare @configNumber int
	select @configNumber = rsi.ConfigNumber from RecordTarget rt 
	inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
	where rt.Number = @targetNumber

select c.Text as [ChoiceText],cs.Score as [ChoiceScore], isNull(r.SelectedCount,0) as [AnswerCount]
from Choice c 
inner join ChoiceScore cs on cs.ChoiceNumber = c.Number
left outer join (
	select rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber, rqs.SelectedChoiceNumber,count(*) as SelectedCount
	from RecordTarget rt
	inner join RecordQuestionScore rqs on rqs.TargetNumber = rt.Number
	where rt.Number = @targetNumber and rqs.SelectedChoiceNumber is not null
	and rqs.QuestionNumber = @questionNumber and  rqs.SubsetNumber = @subsetNumber and rqs.GroupingNumber = @groupingNumber
	group by rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber, rqs.SelectedChoiceNumber
) r on r.SelectedChoiceNumber = c.Number
where c.QuestionNumber = @questionNumber and cs.ConfigNumber = @configNumber



-------------------------



declare @publishNumber int = 106
--	,@groupId varchar(20) = null, @groupTeacherId varchar(20) = null, @groupRole varchar(20) = null
,@groupId varchar(20) = '982CMNCT20D57900', @groupTeacherId varchar(20) = 'T8900167', @groupRole varchar(20) = '1000'
,@memberDepartmentId varchar(20) = null, @memberGrade tinyint = null, @memberRole varchar(20) = null
,@questionNumber int = 1092, @subsetNumber int = 2444, @groupingNumber int = 0

exec sp_AnswerLog_GetChoiceCountList @publishNumber,@groupId,@groupTeacherId,@groupRole,@memberDepartmentId,@memberGrade,@memberRole,@questionNumber,@subsetNumber,@groupingNumber


select * from RecordTarget where [Guid] = 'bbee3832-4d11-4a20-9e53-831d6299b047'


	select rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber, rqs.SelectedChoiceNumber,count(*) as SelectedCount
	from RecordTarget rt
	inner join RecordQuestionScore rqs on rqs.TargetNumber = rt.Number
	where rt.Number = @targetNumber and rqs.SelectedChoiceNumber is not null
	and rqs.QuestionNumber = @questionNumber and  rqs.SubsetNumber = @subsetNumber and rqs.GroupingNumber = @groupingNumber
	group by rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber, rqs.SelectedChoiceNumber




RecordTarget rt
inner join RecordQuestionScore rqs on rqs.TargetNumber = rt.Number
where rt.Number = @targetNumber
and rqs.QuestionNumber = @questionNumber 
and rqs.SubsetNumber = @subsetNumber and rqs.GroupingNumber = @groupingNumber

*/