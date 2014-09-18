-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AnswerLog_GetOpenAnswerList] 
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

	select x.ChoiceText, y.* from (
		select Number as ChoiceNumber, [Text] as ChoiceText
		from Choice c
		where QuestionNumber = @questionNumber
		union
		select 0 as ChoiceNumber, OptionOtherLabel as ChoiceText
		from Question 
		where Number = @questionNumber and OptionShowOther = 1
	) x
	right outer join 
	(	select /*r.Number, w.QuestionNumber,w.SubsetNumber, w.GroupingNumber,*/
		v.ChoiceNumber, r.LastAccessTime, t.[Text] as AnswerText
		from fn_GetFilteredRecords(@publishNumber, @groupId, @groupTeacherId, @groupRole, @memberDepartmentId, @memberGrade, @memberRole) FR
		inner join Record r on r.Number = FR.RecordNumber
		inner join RecordRaw w on w.RecordNumber = r.Number
		inner join RecordRawText t on t.RawNumber = w.Number
		left outer join RecordRawValue v on v.RawNumber = w.Number -- 其他

		where w.QuestionNumber = @questionNumber and w.SubsetNumber = @subsetNumber and w.GroupingNumber = @groupingNumber
		and r.[GroupId] = isNull(@groupId, r.[GroupId])
		and r.[GroupRole] = isNull(@groupRole, r.[GroupRole])
		and r.[GroupTeacherId] = isNull(@groupTeacherId, r.[GroupTeacherId])
		and t.[Text] is not null
	) y on y.ChoiceNumber = x.ChoiceNumber


END

/*
declare @publishNumber int = 106
,@groupId varchar(20) = '982CMNCT20D57900', @groupTeacherId varchar(20) = 'T8900167', @groupRole varchar(20) = '1000'
,@memberDepartmentId varchar(20) = null, @memberGrade tinyint = null, @memberRole varchar(20) = null
,@questionNumber int = 1092, @subsetNumber int = 2444, @groupingNumber int = 0

exec sp_AnswerLog_GetOpenAnswerList @publishNumber,@groupId,@groupTeacherId,@groupRole,@memberDepartmentId,@memberGrade,@memberRole,@questionNumber,@subsetNumber,@groupingNumber

*/