-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	將一個題目複製到指定的問卷內，同時會影響到[Choice]與[Subset]表
-- =============================================
CREATE PROCEDURE [dbo].[sp_Question_Copy]
	-- Add the parameters for the stored procedure here

	@questionNumber int
	,@newPaperNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- 複製題目必須一起複製Choice與Subset

	begin tran T1

	INSERT INTO [dbo].[Question]
	([SurveyNumber],[Section],[Title],[Text],[Description],[Sequence],[Page],[IsRequired],[Guid],[SortOrder],[Skipable]
	,[SkipText],[GenerateChoiceFromAcceptedText],[OptionDisplayType],[OptionIsVerticalList],[OptionDisplayPerRow]
	,[OptionMultipleSelection],[OptionLimitMin],[OptionLimitMax],[OptionDisplayLines],[OptionIsRequired],[OptionLabelLeft]
	,[OptionLabelRight],[OptionLevelStart],[OptionLevelEnd],[OptionShowOther],[OptionAppendToChoice],[OptionOtherLabel])
	select @newPaperNumber,[Section],[Title],[Text],[Description],[Sequence],[Page],[IsRequired],newid(),[SortOrder],[Skipable]
	,[SkipText],[GenerateChoiceFromAcceptedText],[OptionDisplayType],[OptionIsVerticalList],[OptionDisplayPerRow]
	,[OptionMultipleSelection],[OptionLimitMin],[OptionLimitMax],[OptionDisplayLines],[OptionIsRequired],[OptionLabelLeft]
	,[OptionLabelRight],[OptionLevelStart],[OptionLevelEnd],[OptionShowOther],[OptionAppendToChoice],[OptionOtherLabel]
	from [dbo].[Question]
	where [Number] = @questionNumber

	declare @newQuestionNumber int = SCOPE_IDENTITY();

	insert into [dbo].[Choice] ([QuestionNumber],[Text],[SortOrder],[AcceptText],[IsJoined])
	select @newQuestionNumber,[Text],[SortOrder],[AcceptText],[IsJoined] from [dbo].[Choice] 
	where [QuestionNumber] = @questionNumber

	insert into [dbo].[Subset] ([Dimension],[QuestionNumber],[Text],[SortOrder])
	select [Dimension],@newQuestionNumber,[Text],[SortOrder] from [dbo].[Subset] 
	where [QuestionNumber] = @questionNumber

	commit tran T1

END
