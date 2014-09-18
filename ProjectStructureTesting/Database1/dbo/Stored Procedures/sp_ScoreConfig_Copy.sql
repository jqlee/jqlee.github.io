-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreConfig_Copy]
	-- Add the parameters for the stored procedure here
	@configNumber int
	,@newPaperNumber int
	,@targetIsTemplate bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	begin tran T1

	declare @publishNumber int = 0;
	select @publishNumber = ps.[Number] 
	from [PublishSetting] ps inner join [SurveyPaper] p on p.PublishNumber = ps.[Number] and p.[PublishVersion] = ps.[LastPublishVersion]
	where p.Number = @newPaperNumber

	insert into [dbo].[ScoreConfig] ([Name], [PaperNumber], [PublishNumber], [Creator], [Created],[Enabled],[Guid],[IsTemplate])
	select 
	[Name], @newPaperNumber, @publishNumber, [Creator], getdate(), 1, newid(), @targetIsTemplate
	from [ScoreConfig] where [Number] = @configNumber

	declare @newConfigNumber int = SCOPE_IDENTITY();


	Insert into [QuestionScore] ([ConfigNumber], [QuestionNumber], [Score])
	select @newConfigNumber, [QuestionNumber], [Score] from [QuestionScore] where [ConfigNumber] = @configNumber

	Insert into [ChoiceScore] ([ConfigNumber], [ChoiceNumber], [Score])
	select @newConfigNumber, [ChoiceNumber], [Score] from [ChoiceScore] where [ConfigNumber] = @configNumber

	commit tran T1
END
