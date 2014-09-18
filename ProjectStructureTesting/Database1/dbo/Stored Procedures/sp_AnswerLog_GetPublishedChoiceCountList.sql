-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AnswerLog_GetPublishedChoiceCountList] 
	-- Add the parameters for the stored procedure here
	@publishNumber int = 89
	,@groupId varchar(20) = null, @groupTeacherId varchar(20) = null, @groupRole varchar(20) = null
	,@memberDepartmentId varchar(20) = null, @memberGrade tinyint = 0, @memberRole varchar(20) = null
	,@questionNumber int = 1033, @subsetNumber int = 0, @groupingNumber int = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
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
		inner join (
			select sc.PublishNumber, rqs.RecordNumber
			from RecordScoreIndex rsi 
			inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
			inner join PublishSetting ps on ps.Number = sc.PublishNumber
			inner join RecordQuestionScore rqs on rqs.IndexNumber = rsi.Number
			inner join Record r on r.Number = rqs.RecordNumber and r.Done = 1
			where ps.Number = @publishNumber and rsi.IsPublished = 1 
				and r.[GroupId] = isNull(@groupId, r.[GroupId])
				and r.[GroupRole] = isNull(@groupRole, r.[GroupRole])
				and r.[GroupTeacherId] = isNull(@groupTeacherId, r.[GroupTeacherId])
			group by sc.PublishNumber, rqs.RecordNumber		
		) z on z.RecordNumber = r.Number
		where r.Done=1 and w.QuestionNumber = @questionNumber and w.SubsetNumber = @subsetNumber and w.GroupingNumber = @groupingNumber
		and r.[GroupId] = isNull(@groupId, r.[GroupId])
		and r.[GroupRole] = isNull(@groupRole, r.[GroupRole])
		and r.[GroupTeacherId] = isNull(@groupTeacherId, r.[GroupTeacherId])
		group by w.QuestionNumber,w.SubsetNumber, w.GroupingNumber, v.ChoiceNumber
	) x on x.ChoiceNumber = c.ChoiceNumber and x.QuestionNumber = c.QuestionNumber
	where c.QuestionNumber = @questionNumber
	order by c.SortOrder
END

/*
declare @publishNumber int = 106
--	,@groupId varchar(20) = null, @groupTeacherId varchar(20) = null, @groupRole varchar(20) = null
,@groupId varchar(20) = '982CMNCT20D57900', @groupTeacherId varchar(20) = 'T8900167', @groupRole varchar(20) = '1000'
,@memberDepartmentId varchar(20) = null, @memberGrade tinyint = null, @memberRole varchar(20) = null
,@questionNumber int = 1092, @subsetNumber int = 2444, @groupingNumber int = 0

exec sp_AnswerLog_GetChoiceCountList @publishNumber,@groupId,@groupTeacherId,@groupRole,@memberDepartmentId,@memberGrade,@memberRole,@questionNumber,@subsetNumber,@groupingNumber


declare @publishNumber int = 106
	,@groupId varchar(20) = '982CMNCT20D57900'
	,@groupRole varchar(6) = '1000'
	,@teacherId varchar(20) = 'T8900167'

--exec sp_ScoreReport_GetInformation @publishNumber,@groupId,@groupRole ,@teacherId

select sc.PublishNumber, rqs.RecordNumber
from RecordScoreIndex rsi 
inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
inner join PublishSetting ps on ps.Number = sc.PublishNumber
inner join RecordQuestionScore rqs on rqs.IndexNumber = rsi.Number
inner join Record r on r.Number = rqs.RecordNumber and r.Done = 1
where ps.Number = @publishNumber and rsi.IsPublished = 1 
	and r.[GroupId] = isNull(@groupId, r.[GroupId])
	and r.[GroupRole] = isNull(@groupRole, r.[GroupRole])
	and r.[GroupTeacherId] = isNull(@teacherId, r.[GroupTeacherId])
group by sc.PublishNumber, rqs.RecordNumber
*/