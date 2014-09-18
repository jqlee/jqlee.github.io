-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_QuestionScore_Save
	-- Add the parameters for the stored procedure here
	@number int = 0
	,@configNumber int = 0
	,@questionNumber int = 0
	,@score decimal = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if (exists(select 0 from QuestionScore where Number = @number))
	begin
		Update QuestionScore set 
			ConfigNumber = @configNumber,
			QuestionNumber = @questionNumber,
			Score = @score
		where Number = @number
	end
	else
	begin
		Insert into QuestionScore
			(ConfigNumber, QuestionNumber, Score)
		Values
			(@configNumber,@questionNumber,@score)
	end
END
