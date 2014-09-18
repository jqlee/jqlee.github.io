-- =============================================
-- Author:		ben lee
-- Create date: 2014-03-06
-- Description:	參數 @copyConfig 的 DataMapping 型別須要先執行過 sp___TypeInitialize 才會產生
-- =============================================
CREATE PROCEDURE [dbo].[sp_Choice_CopyAll]
	-- Add the parameters for the stored procedure here
	@questionNumber int
	,@newQuestionNumber int
	,@copyConfig DataMapping READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @temp Table ([Index] int identity(1,1), [ChoiceNumber] int)
	--暫存需要複製的選項編號
	insert into @temp ([ChoiceNumber])
	select [Number] as [ChoiceNumber] 
	from [dbo].[Choice] 
	where [QuestionNumber] = @questionNumber

	declare @current int = 0
	while (exists(select 0 from @temp))
	begin
		select @current = Min([ChoiceNumber]) from @temp

		exec sp_Choice_CopyOne @choiceNumber=@current, @newQuestionNumber=@newQuestionNumber,@copyConfig=@copyConfig

		delete from @temp where [ChoiceNumber] = @current
	end

	
END
