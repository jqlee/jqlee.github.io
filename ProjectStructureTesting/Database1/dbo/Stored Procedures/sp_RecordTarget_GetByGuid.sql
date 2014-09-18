
CREATE PROCEDURE [dbo].[sp_RecordTarget_GetByGuid]
	@guid uniqueidentifier = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 rs.*, ps.Name as PublishName, rsi.[Guid] as [IndexGuid]
	FROM [dbo].[RecordTarget] rs
	inner join PublishSetting ps on ps.Number = rs.PublishNumber
	inner join ScoreConfig sc on sc.PublishNumber = rs.PublishNumber
	inner join RecordScoreIndex rsi on rsi.ConfigNumber = sc.Number and rsi.IsPublished = 1
	where rs.[Guid] = @guid
END

