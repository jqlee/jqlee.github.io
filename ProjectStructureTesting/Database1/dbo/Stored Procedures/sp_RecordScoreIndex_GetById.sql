
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 rsi.* -- [Number], [ConfigNumber], [Created], [Creator], [RecordCount]
		,m.Name as CreatorName
	FROM [dbo].[RecordScoreIndex] rsi
	left outer join v_Member m on m.Id = rsi.Creator
	where rsi.[Number] = @number
END

