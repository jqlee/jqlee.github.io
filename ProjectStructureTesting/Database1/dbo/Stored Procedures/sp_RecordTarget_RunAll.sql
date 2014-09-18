-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordTarget_RunAll]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	update RecordTarget set Done = 0


	declare @targetNumber int
	--declare @finalScore float, @stdevpScore float
	
	update RecordTarget set Done = 0

	while (exists(select 0 from RecordTarget where Done = 0))
	begin
		select @targetNumber = [Number] from RecordTarget where Done = 0

		exec sp_RecordTarget_SaveRecords @targetNumber
		
		/*
		exec sp_RecordQuestionScore_SaveByTarget @targetNumber
		
		select @finalScore = Sum(AverageScore*QuestionRate/100)
			,@stdevpScore = sum(StdevpScore*QuestionRate/100)
		from fn_GetTargetScore(@targetNumber)

		update RecordTarget
		 set Done = 1,FinalScore=@finalScore, StdevpScore = @stdevpScore
		 where Number = @targetNumber
		*/
	end
	


END
