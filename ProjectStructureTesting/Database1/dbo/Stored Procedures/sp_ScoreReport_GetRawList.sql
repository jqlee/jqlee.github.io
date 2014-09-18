-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetRawList]
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- 可能要把configNumber跟IndexNumber提出來先查好，方便在外層找target

select q.Title as QuestionTitle, q.AreaTitle
,x.* from (
	select rsi.ConfigNumber, r.MemberId, r.MemberName, rs.* from RecordScoreIndex rsi
	inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
	inner join Record r on r.Number = rs.RecordNumber
	where rsi.[Guid] = @indexGuid and rs.RawScore is not null
	--order by rs.QuestionNumber, rs.SubsetNumber, rs.GroupingNumber
) x
inner join v_QuestionUnit q on q.QuestionNumber = x.QuestionNumber and q.SubsetNumber = x.SubsetNumber and q.GroupingNumber = x.GroupingNumber
order by x.RecordNumber, q.SortOrder

END
