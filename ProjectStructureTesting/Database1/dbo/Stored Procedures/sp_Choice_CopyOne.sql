
-- =============================================
-- Author:		ben lee
-- Create date: 2014-03-06
-- Description:	參數 @copyConfig 的 DataMapping 型別須要先執行過 sp___TypeInitialize 才會產生
-- =============================================
CREATE PROCEDURE [dbo].[sp_Choice_CopyOne]
	-- Add the parameters for the stored procedure here
	@choiceNumber int
	,@newQuestionNumber int
	,@copyConfig DataMapping READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	begin tran t1

	insert into [dbo].[Choice] ([QuestionNumber],[Text],[SortOrder],[AcceptText],[IsJoined])
	select @newQuestionNumber,[Text],[SortOrder],[AcceptText],[IsJoined] 
	from [dbo].[Choice] 
	where [Number] = @choiceNumber
	
	declare @newChoiceNumber int = SCOPE_IDENTITY()

	if (exists(select 0 from @copyConfig))
	begin
		insert into [ChoiceScore] ([ConfigNumber],[ChoiceNumber],[Score])
		select distinct cc.[toNumber] as [ConfigNumber],@newChoiceNumber as [ChoiceNumber], [Score]
		from [ChoiceScore] cs
		inner join @copyConfig cc on cc.[numberFrom] = cs.ConfigNumber
		where cs.ChoiceNumber = @choiceNumber
	end


	-- translation
	exec sp_Translation_Copy @category='choice',@dataNumber=@choiceNumber,@newDataNumber=@newChoiceNumber


	commit tran t1

END
