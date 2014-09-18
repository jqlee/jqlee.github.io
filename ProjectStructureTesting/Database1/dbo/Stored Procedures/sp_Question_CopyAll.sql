-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Question_CopyAll]
	-- Add the parameters for the stored procedure here
	@paperNumber int
	,@newPaperNumber int
	,@copyConfig DataMapping READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	declare @temp Table ([Number] int identity(1,1), [QuestionNumber] int)
	insert into @temp ([QuestionNumber])
	SELECT [Number] as [QuestionNumber] from [dbo].[Question] where [SurveyNumber] = @paperNumber;

	begin tran T1

	declare @currentQuestion int
	while (exists(select 0 from @temp))
	begin
		select @currentQuestion = [QuestionNumber] from @temp
		--print @currentQuestion;
		exec sp_Question_CopyOne @questionNumber = @currentQuestion ,@newPaperNumber = @newPaperNumber, @copyConfig = @copyConfig
		delete from @temp where [QuestionNumber] = @currentQuestion
	end

	commit tran T1
	
END
