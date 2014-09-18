-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_StatQuestion_SaveReport]
	-- Add the parameters for the stored procedure here
	--@indexGuid uniqueidentifier 
	@indexNumber int = 0
	/*
	,@memberCount int = 0
	,@groupId varchar(20) = null
	,@groupRole varchar(6) = null
	,@teacherId varchar(20) = null
	*/
	/* 人員問卷先不作 */
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- 可能要把configNumber跟IndexNumber提出來先查好，方便在外層找target

	/**/

	Delete from [dbo].[StatQuestion]
	where IndexNumber = @indexNumber

	INSERT INTO [dbo].[StatQuestion]
	([PublishNumber],[ConfigNumber],[IndexNumber]
	,[QuestionNumber],[SubsetNumber],[GroupingNumber]
	,[SortOrder],[QuestionSort],[SubsetSort],[GroupingSort]
	,[AnswerCount],[AverageScore],[StdevpScore])
	
	select 
	x.PublishNumber, x.ConfigNumber,x.IndexNumber
	--, q.Title as QuestionTitle, q.AreaTitle
	, x.[QuestionNumber],x.[SubsetNumber],x.[GroupingNumber]
	, Row_Number() over (order by q.SortOrder) as [SortOrder]
	, q.QuestionSort, q.SubsetSort, q.GroupingSort
	, x.[AnswerCount],x.[AverageScore],x.[StdevpScore]
	from (
		select PublishNumber, ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber
			, count(RecordNumber) as AnswerCount
			, AVG(GainScore) as AverageScore 
			--, STDEV(TotalScore) as StdevScore 
			, STDEVP(GainScore) as StdevpScore
		from (
			select sc.PublishNumber, rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber, sum((rs.RawScore)) as GainScore
			from RecordScoreIndex rsi
			inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
			inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
			inner join Record r on r.Number = rs.RecordNumber
			where rsi.Number = @indexNumber and rs.RawScore is not null
			
			--rsi.[Guid] = @indexGuid and rs.RawScore is not null
			/*
			 and r.[GroupId] = isNull(@groupId, [GroupId])
			 and r.[GroupRole] = isNull(@groupRole, [GroupRole])
			 and r.[GroupTeacherId] = isNull(@teacherId, [GroupTeacherId])
			*/
			group by sc.PublishNumber, rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber
		) x
		group by PublishNumber, ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber
	) x
	inner join v_QuestionUnit q on q.QuestionNumber = x.QuestionNumber and q.SubsetNumber = x.SubsetNumber and q.GroupingNumber = x.GroupingNumber
	order by q.SortOrder

END

/*
exec sp_StatQuestion_SaveReport 185

--select * from SurveyPaper order by Number desc
--select * from v_QuestionUnit q where q.SurveyNumber = 313

declare @indexGuid uniqueidentifier = '4dc82cfe-f578-416f-bdb5-0b67720b295e'
,@memberCount int = 100
exec sp_StatQuestion_SaveReport @indexGuid

---exec sp_ScoreReport_GetListByQuestionItem @indexGuid,@memberCount

select Row_Number() over ( order by q.SortOrder) as [SortOrder]
,q.Title as QuestionTitle, q.AreaTitle, q.QuestionSort, q.SubsetSort, q.GroupingSort
,x.* from (
	select ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber, @memberCount as MemberCount
		, count(RecordNumber) as RecordCount, AVG(TotalScore) as AvgScore , STDEV(TotalScore) as StdevScore , STDEVP(TotalScore) as StdevpScore
	from (
		select rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber, sum((rs.RawScore)) as TotalScore
		from RecordScoreIndex rsi
		inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
		inner join Record r on r.Number = rs.RecordNumber
		where rsi.[Guid] = @indexGuid and rs.RawScore is not null
		group by rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber
	) x
	group by ConfigNumber, IndexNumber, QuestionNumber, SubsetNumber, GroupingNumber
) x
inner join v_QuestionUnit q on q.QuestionNumber = x.QuestionNumber and q.SubsetNumber = x.SubsetNumber and q.GroupingNumber = x.GroupingNumber


*/
