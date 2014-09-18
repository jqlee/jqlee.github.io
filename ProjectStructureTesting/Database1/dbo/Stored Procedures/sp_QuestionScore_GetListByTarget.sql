-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_QuestionScore_GetListByTarget
	-- Add the parameters for the stored procedure here
	 @targetNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	Select qs.* , q.Title as QuestionTitle
	from PublishTarget pt
	inner join PublishSetting ps on ps.Number = pt.PublishNumber
	--inner join ScoreConfig sc on sc.Number = ps.ScoreConfigNumber
	inner join QuestionScore qs on qs.ConfigNumber = ps.ScoreConfigNumber and qs.Score > 0
	inner join Question q on q.Number = qs.QuestionNumber
	where pt.Number = @targetNumber 

END
