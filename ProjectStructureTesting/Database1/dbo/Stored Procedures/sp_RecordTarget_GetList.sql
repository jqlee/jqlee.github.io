
CREATE PROCEDURE [dbo].[sp_RecordTarget_GetList]
	@publishGuid uniqueidentifier
	,@groupId varchar(20) = null
	,@teacherId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;

	select rt.* 
	from RecordTarget rt
	 inner join PublishSetting ps on ps.Number = rt.PublishNumber
	 inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber and rsi.IsPublished = 1
	where ps.Guid = @publishGuid
	 and rt.GroupId = isNull(@groupId,rt.GroupId)
	 and rt.GroupTeacherId = isNull(@teacherId,rt.GroupTeacherId)

	/*
	SELECT rs.*
	FROM [dbo].[RecordTarget] rs
	inner join [dbo].[RecordScoreIndex] rsi on rsi.Number = rs.[IndexNumber] and rsi.IsPublished = 1
	inner join [dbo].[ScoreConfig] sc on sc.Number = rsi.ConfigNumber
	inner join [dbo].[PublishSetting] ps on ps.Number = sc.PublishNumber
	where ps.[Guid] = @publishGuid

	*/
	--where rsi.[Guid] = @indexGuid

	/*
	select IndexNumber, RecordNumber, sum(Score) as TotalScore 
	from [RecordQuestionScore]
	where [IndexNumber] = isNull(@indexNumber,[IndexNumber])
	group by IndexNumber,RecordNumber
	*/

	/*
	RecordTarget 資料改由 RecordQuestionScore grouping來，不存實體紀錄
	SELECT [Number], [IndexNumber], [RecordNumber], [Score]
	FROM [dbo].[RecordTarget]
	where [IndexNumber] = isNull(@indexNumber,[IndexNumber])
	*/
END
