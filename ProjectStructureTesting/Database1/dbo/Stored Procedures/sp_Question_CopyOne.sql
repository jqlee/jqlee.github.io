-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	將一個題目複製到指定的問卷內，同時會影響到[Choice]與[Subset]表
--              參數 @copyConfig 的 DataMapping 型別須要先執行過 sp___TypeInitialize 才會產生
-- =============================================
CREATE PROCEDURE [dbo].[sp_Question_CopyOne]
	-- Add the parameters for the stored procedure here

	@questionNumber int
	,@newPaperNumber int
	,@copyConfig DataMapping READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- 複製題目必須一起複製Choice與Subset
	declare @newQuestionGuid uniqueidentifier = newid()

	begin tran T1

	INSERT INTO [dbo].[Question]
	([SurveyNumber],[Section],[Title],[Text],[Description],[Sequence],[Page],[IsRequired],[Guid],[SortOrder],[Skipable]
	,[SkipText],[GenerateChoiceFromAcceptedText],[OptionDisplayType],[OptionIsVerticalList],[OptionDisplayPerRow]
	,[OptionMultipleSelection],[OptionLimitMin],[OptionLimitMax],[OptionDisplayLines],[OptionIsRequired],[OptionLabelLeft]
	,[OptionLabelRight],[OptionLevelStart],[OptionLevelEnd],[OptionShowOther],[OptionAppendToChoice],[OptionOtherLabel])
	select @newPaperNumber,[Section],[Title],[Text],[Description],[Sequence],[Page],[IsRequired], @newQuestionGuid ,[SortOrder],[Skipable]
	,[SkipText],[GenerateChoiceFromAcceptedText],[OptionDisplayType],[OptionIsVerticalList],[OptionDisplayPerRow]
	,[OptionMultipleSelection],[OptionLimitMin],[OptionLimitMax],[OptionDisplayLines],[OptionIsRequired],[OptionLabelLeft]
	,[OptionLabelRight],[OptionLevelStart],[OptionLevelEnd],[OptionShowOther],[OptionAppendToChoice],[OptionOtherLabel]
	from [dbo].[Question]
	where [Number] = @questionNumber

	declare @newQuestionNumber int -- = SCOPE_IDENTITY();
	select @newQuestionNumber = [Number] from Question where [Guid] = @newQuestionGuid

	insert into QuestionScore
	select cc.[toNumber] as [ConfigNumber], @newQuestionNumber as [QuestionNumber],qs.[Score]
	from QuestionScore qs
	inner join @copyConfig cc on cc.[numberFrom] = qs.ConfigNumber
	where qs.QuestionNumber = @questionNumber

	begin tran tt
	/*
	題目必須複製下列翻譯
	3	question
	4	quesdesc
	5	levelleft
	6	levelright
	7	labelother
	*/
	exec sp_Translation_Copy @category='question',@dataNumber=@questionNumber,@newDataNumber=@newQuestionNumber
	exec sp_Translation_Copy @category='quesdesc',@dataNumber=@questionNumber,@newDataNumber=@newQuestionNumber
	exec sp_Translation_Copy @category='levelleft',@dataNumber=@questionNumber,@newDataNumber=@newQuestionNumber
	exec sp_Translation_Copy @category='levelright',@dataNumber=@questionNumber,@newDataNumber=@newQuestionNumber
	exec sp_Translation_Copy @category='labelother',@dataNumber=@questionNumber,@newDataNumber=@newQuestionNumber
	commit tran tt

	/*
	insert into [dbo].[Subset] ([Dimension],[QuestionNumber],[Text],[SortOrder])
	select [Dimension],@newQuestionNumber,[Text],[SortOrder] 
	from [dbo].[Subset] 
	where [QuestionNumber] = @questionNumber
	*/
	exec sp_Subset_CopyByQuestion @questionNumber=@questionNumber, @newQuestionNumber=@newQuestionNumber

	exec sp_Choice_CopyAll @questionNumber,@newQuestionNumber,@copyConfig


	commit tran T1

END
/*

declare @paperNumber int = 295
declare @newPaperNumber int = 888

select * from [Subset]
declare @questionNumber int = 877
declare @newQuestionNumber int
declare @newQuestionGuid uniqueidentifier = newid()

select * from Question where Number = @questionNumber
-- insert question ....
select @newQuestionNumber = [Number] from Question where [Guid] = @newQuestionGuid

declare @configGuid uniqueidentifier = 'C006BE92-DEA6-402C-87B8-9CC625CC74E4'
declare @newConfigNumber int = 999

select 0 as [Number], @newConfigNumber as [ConfigNumber], @newQuestionNumber as [QuestionNumber], qs.Score
from ScoreConfig sc
inner join QuestionScore qs on qs.ConfigNumber = sc.Number
inner join Question q on q.Number = qs.QuestionNumber
where sc.[Guid] = @configGuid and q.Number = @questionNumber

select 0 as [Number], @newConfigNumber as [ConfigNumber], qs.QuestionNumber, qs.Score
from ScoreConfig sc
inner join QuestionScore qs on qs.ConfigNumber = sc.Number
where sc.[Guid] = @configGuid


--1115
DECLARE @qnumber int = 1, @pnumber int = 1115
select * from Question where Number = @qnumber
select * from ScoreConfig where PaperNumber = @pnumber
select * from QuestionScore where QuestionNumber = @qnumber
select cs.* from Choice c
inner join ChoiceScore cs on cs.ChoiceNumber = c.Number
where c.QuestionNumber = @qnumber
select * from ChoiceScore where




sp_Choice_CopyOne

declare @choiceNumber int
declare @newQuestionNumber int

	insert into [dbo].[Choice] ([QuestionNumber],[Text],[SortOrder],[AcceptText],[IsJoined])
	select @newQuestionNumber,[Text],[SortOrder],[AcceptText],[IsJoined] 
	from [dbo].[Choice] 
	where [Number] = @choiceNumber
	declare @newChoiceNumber int = SCOPE_IDENTITY()

	*/