
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_SetIsPublished]
	@guid uniqueidentifier = null
AS
BEGIN
	SET NOCOUNT ON;

	begin tran t1

	declare @publishNumber int
	select @publishNumber = sc.PublishNumber
	from [RecordScoreIndex] rsi
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	where rsi.[Guid] = @guid

	-- others
	update [RecordScoreIndex] set IsPublished = 0
	from [RecordScoreIndex] rsi
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	where sc.PublishNumber = @publishNumber

	SET NOCOUNT OFF;
	update [RecordScoreIndex] set IsPublished = 1
	where [Guid] = @guid

	commit tran t1

END

