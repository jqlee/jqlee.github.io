-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_DeleteScore]
	-- Add the parameters for the stored procedure here
	@guid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	begin Tran t1
		Delete from RecordTarget
		from RecordScoreIndex idx 
		inner join RecordTarget rs on rs.IndexNumber = idx.Number
		where idx.[Guid] = @guid

		Delete from RecordQuestionScore
		from RecordScoreIndex idx 
		inner join RecordQuestionScore rs on rs.IndexNumber = idx.Number
		where idx.[Guid] = @guid
	
		Delete from RecordScoreIndex where [Guid] = @guid

		--update RecordScoreIndex set [Enabled] = 0 where [Guid] = @guid
	
	commit Tran t1

	END
