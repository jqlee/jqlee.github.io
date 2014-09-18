-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp__GenerateUncompletedRecordAnswers]
	-- Add the parameters for the stored procedure here
	@publishNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @paperNumber int -- 為了處理發布問題，在此要多查一個試卷編號
	select @paperNumber = p.[Number]
	from [PublishSetting] ps inner join [SurveyPaper] p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	where ps.Number = @publishNumber

    insert into [RecordRaw] ([RecordNumber],[QuestionNumber],[SubsetNumber],[GroupingNumber],[TempChoiceValue],[ChooseCount])
	select [RecordNumber],[QuestionNumber],[SubsetNumber],[GroupingNumber],[TempChoiceValue],[ChooseCount] 
	from (
		select r.PublishNumber, r.GroupId,r.GroupTeacherId,r.GroupRole, r.Number as [RecordNumber] 
		, q.QuestionNumber,q.SubsetNumber, q.GroupingNumber
		,(select top 1 c.Number 
			from [Choice] c
			inner join [v_QuestionUnit] qq on c.QuestionNumber = qq.QuestionNumber
			where qq.QuestionNumber = q.QuestionNumber and qq.SubsetNumber = q.SubsetNumber  and qq.GroupingNumber = q.GroupingNumber
			order by HASHBYTES('md5',cast((c.Number+r.Number+q.QuestionNumber+q.SubsetNumber+q.GroupingNumber) as varchar))
		) as [TempChoiceValue], 1 as [ChooseCount]
		from Record r
		--left outer join RecordTarget rt on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
		inner join (
			select q.SurveyNumber, q.QuestionNumber,q.SubsetNumber, q.GroupingNumber,q.[SortOrder], q.SubsetSort, q.GroupingSort 
			from v_QuestionUnit q
			where /*q.SurveyNumber = @paperNumber and*/ q.CanScore = 1
		) q on q.SurveyNumber = r.SurveyNumber
		where r.[PublishNumber] = @publishNumber and r.SurveyNumber = @paperNumber and r.Done = 0
	) x
	order by  GroupId,GroupTeacherId,GroupRole, QuestionNumber,SubsetNumber, GroupingNumber


	begin tran tv

	delete from RecordRawValue
	from Record r 
	inner join RecordRaw w on w.RecordNumber = r.Number
	inner join RecordRawValue v on v.RawNumber = w.Number
	where r.PublishNumber = @publishNumber and r.Done = 0

	insert into RecordRawValue (RawNumber, ChoiceNumber)
	select w.Number as RawNumber,w.TempChoiceValue 
	from Record r inner join RecordRaw w on w.RecordNumber = r.Number
	where r.PublishNumber = @publishNumber and r.Done = 0 and w.[TempChoiceValue] is not null

	commit tran tv

END


/*

declare @publishGuid uniqueidentifier = '10b22d37-7930-41f1-8b32-7ef1824202fe' -- '33905d66-13db-47b2-ab1d-af30cd32a19d'
	, @maxCount int = 1000
--exec sp__ @publishGuid,  @maxCount

--select * from PublishSetting where [Guid] = @publishGuid

declare @publishNumber int;
select @publishNumber = [Number] from PublishSetting where [Guid] = @publishGuid


declare @paperNumber int -- 為了處理發布問題，在此要多查一個試卷編號
select @paperNumber = p.[Number]
from [PublishSetting] ps inner join [SurveyPaper] p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
where ps.Number = @publishNumber

	--select TempChoiceValue, QuestionNumber,SubsetNumber, GroupingNumber, count(RecordNumber) as AnswerCount
	select GroupId, GroupTeacherId, GroupRole, TempChoiceValue, QuestionNumber,SubsetNumber, GroupingNumber, RecordNumber
	from (
	select r.Number as [RecordNumber], r.GroupId, r.GroupTeacherId, r.GroupRole
	, q.QuestionNumber,q.SubsetNumber, q.GroupingNumber
	,(select top 1 c.Number 
		from [Choice] c
		inner join [v_QuestionUnit] qq on c.QuestionNumber = qq.QuestionNumber
		where qq.QuestionNumber = q.QuestionNumber and qq.SubsetNumber = q.SubsetNumber  and qq.GroupingNumber = q.GroupingNumber
		order by HASHBYTES('md5',cast((c.Number+r.Number+q.QuestionNumber+q.SubsetNumber+q.GroupingNumber) as varchar))
	) as [TempChoiceValue], 1 as [ChooseCount]
	from Record r
	inner join (
		select q.SurveyNumber, q.QuestionNumber,q.SubsetNumber, q.GroupingNumber,q.[SortOrder], q.SubsetSort, q.GroupingSort 
		from v_QuestionUnit q
		where q.CanScore = 1
	) q on q.SurveyNumber = r.SurveyNumber
	where r.[PublishNumber] = @publishNumber and r.SurveyNumber = @paperNumber and r.Done = 0
	
	) x
	-- group by r.GroupId, r.GroupTeacherId, r.GroupRole, TempChoiceValue, QuestionNumber,SubsetNumber, GroupingNumber
	order by GroupId, GroupTeacherId, GroupRole, TempChoiceValue, QuestionNumber,SubsetNumber, GroupingNumber --,RecordNumber



*/



/*


exec sp__GenerateUncompletedRecord 32
exec sp__GenerateUncompletedRecordAnswers 32

declare @publishNumber int = 32
	declare @paperNumber int -- 為了處理發布問題，在此要多查一個試卷編號
	select @paperNumber = p.[Number]
	from [PublishSetting] ps inner join [SurveyPaper] p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	where ps.Number = @publishNumber

	select r.Number as [RecordNumber] 
	, q.QuestionNumber,q.SubsetNumber, q.GroupingNumber
	,(select top 1 c.Number 
		from [Choice] c
		inner join [v_QuestionUnit] qq on c.QuestionNumber = qq.QuestionNumber
		where qq.QuestionNumber = q.QuestionNumber and qq.SubsetNumber = q.SubsetNumber  and qq.GroupingNumber = q.GroupingNumber
		order by HASHBYTES('md5',cast((c.Number+r.Number) as varchar))
	) as [TempChoiceValue], 1 as [ChooseCount]
	from Record r
	inner join (
		select q.SurveyNumber, q.QuestionNumber,q.SubsetNumber, q.GroupingNumber,q.[SortOrder], q.SubsetSort, q.GroupingSort 
		from v_QuestionUnit q
		where /*q.SurveyNumber = @paperNumber and*/ q.CanScore = 1
	) q on q.SurveyNumber = r.SurveyNumber
	where r.[PublishNumber] = @publishNumber and r.SurveyNumber = @paperNumber and r.Done = 0
	order by q.QuestionNumber,q.SubsetNumber, q.GroupingNumber, r.Number


*/

/*
9085	1168	2660	0	5012
9086	1168	2660	0	5011
9087	1168	2660	0	5009
*/
/*
select w.* 
from RecordRaw w
where  w.QuestionNumber = 1168 and w.SubsetNumber = 2660
*/