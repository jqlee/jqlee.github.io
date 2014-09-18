-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetListByRecord]
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- 可能要把configNumber跟IndexNumber提出來先查好，方便在外層找target

select 
r.LastAccessTime
,x.* from (
	select rsi.ConfigNumber, rs.RecordNumber, r.MemberId, r.MemberName, sum((rs.RawScore*rs.QuestionScoreSetting/100)/rs.QuestionItemCount) as TotalScore
	from RecordScoreIndex rsi
	inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
	inner join (select QuestionNumber,count(*) as ItemCount from v_QuestionUnit group by QuestionNumber) q on q.QuestionNumber = rs.QuestionNumber
	inner join QuestionScore qs on qs.QuestionNumber = rs.QuestionNumber and qs.ConfigNumber = rsi.ConfigNumber
	inner join Record r on r.Number = rs.RecordNumber
	where rsi.[Guid] = @indexGuid
	group by rsi.ConfigNumber,  rs.RecordNumber, r.MemberId, r.MemberName
	--order by rs.RecordNumber
) x 
left outer join Record r on r.Number = x.RecordNumber


END
