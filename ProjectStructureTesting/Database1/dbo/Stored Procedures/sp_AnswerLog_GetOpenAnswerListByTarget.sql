-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AnswerLog_GetOpenAnswerListByTarget] 
	-- Add the parameters for the stored procedure here
	@targetGuid uniqueidentifier 
	--,@groupId varchar(20) = null, @groupTeacherId varchar(20) = null, @groupRole varchar(20) = null
	--,@memberDepartmentId varchar(20) = null, @memberGrade tinyint = 0, @memberRole varchar(20) = null
	--,@questionNumber int = 1033, @subsetNumber int = 0, @groupingNumber int = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select w.QuestionNumber, w.SubsetNumber, w.GroupingNumber, x.ChoiceText,v.ChoiceNumber,r.Number as RecordNumber,r.LastAccessTime,w.AnswerText
	from RecordTarget rt
		inner join Record r on r.PublishNumber = rt.PublishNumber and r.GroupId = rt.GroupId and r.GroupTeacherId = rt.GroupTeacherId
		inner join RecordRaw w on w.RecordNumber = r.Number
		inner join RecordRawText t on t.RawNumber = w.Number
		left outer join RecordRawValue v on v.RawNumber = w.Number -- 其他
		left outer join (
			select QuestionNumber, Number as ChoiceNumber, [Text] as ChoiceText
			from Choice c
			--where QuestionNumber = w.QuestionNumber
			union
			select Number as QuestionNumber, 0 as ChoiceNumber, OptionOtherLabel as ChoiceText
			from Question 
			where /*Number = w.QuestionNumber and*/ OptionShowOther = 1
		) x on x.QuestionNumber = w.QuestionNumber and x.ChoiceNumber = v.ChoiceNumber
	where rt.[Guid] = @targetGuid and AnswerText is not null


END

/*
declare @publishNumber int = 106
,@groupId varchar(20) = '982CMNCT20D57900', @groupTeacherId varchar(20) = 'T8900167', @groupRole varchar(20) = '1000'
,@memberDepartmentId varchar(20) = null, @memberGrade tinyint = null, @memberRole varchar(20) = null
,@questionNumber int = 1092, @subsetNumber int = 2444, @groupingNumber int = 0

exec sp_AnswerLog_GetOpenAnswerList @publishNumber,@groupId,@groupTeacherId,@groupRole,@memberDepartmentId,@memberGrade,@memberRole,@questionNumber,@subsetNumber,@groupingNumber

*/