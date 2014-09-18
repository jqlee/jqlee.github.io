-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyPaper_Copy]
	-- Add the parameters for the stored procedure here
	@paperNumber int,
	@newPublishNumber int = 0,
	@newGuid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	/*
	-- 分數設定是綁死在試卷的題目跟選項上的，
	-- 複製試卷時，當執行到複製題目的時候就必須一併複製分數設定，
	-- 所以要在開始複製題目之前就先產生好新的設定，然後將設定檔的guid傳給複製題目的程序，複製選項也相同
	-- 
	*/

	SET NOCOUNT ON;

	--定義變數
	declare @newPaperNumber int;
	declare @publishNumber int = 0;
	declare @newConfigGuid uniqueidentifier 
	declare @configNumber int
	declare @newConfigNumber int

	select @publishNumber = p.PublishNumber from  [SurveyPaper] p where p.Number = @paperNumber

    -- Insert statements for procedure here
	begin tran TPaper

	--複製試卷
	INSERT INTO [dbo].[SurveyPaper]
	([SchoolId],[Title],[Description],[Enabled],[Creator],[Created],[LastModified],[DefaultLangCode]
	,[Guid],[IsTemplate],[PublishNumber],[PublishVersion])
	Select [SchoolId],[Title],[Description],1,[Creator],getdate(),getdate(),[DefaultLangCode]
	,@newGuid,[IsTemplate], null, null
	from [dbo].[SurveyPaper] where [Number] = @paperNumber

	--set @newPaperNumber = SCOPE_IDENTITY();
	select @newPaperNumber = [Number] from SurveyPaper where [Guid] = @newGuid

	begin tran tt
	-- copy translation
	-- 除了複製字串，還要複製PaperLanguage
	
	--select * from PaperLanguage
	insert into PaperLanguage (PaperNumber,LangNumber,[Enabled])
	select @newPaperNumber as PaperNumber,LangNumber,[Enabled]
	from PaperLanguage where PaperNumber = @paperNumber


	exec sp_Translation_Copy @category='papertitle',@dataNumber=@paperNumber,@newDataNumber=@newPaperNumber
	exec sp_Translation_Copy @category='paperdesc',@dataNumber=@paperNumber,@newDataNumber=@newPaperNumber
	--select * from PaperLanguageCategory
	commit tran tt

	--製作config的DataMapping

	--//複製分數設定(迴圈)

	declare @temp Table ([Number] int identity(1,1), [ConfigNumber] int)
	insert into @temp ([ConfigNumber])
	SELECT [Number] as [ConfigNumber] from [dbo].[ScoreConfig] where [PaperNumber] = @paperNumber;

	if (@newPublishNumber <> 0) set @publishNumber = @newPublishNumber;

	declare @copyConfig DataMapping	

	begin tran TConfig

	while (exists(select 0 from @temp))
	begin
		select @configNumber = min([ConfigNumber]) from @temp
		--print @currentQuestion;
		set @newConfigGuid = newid();
		insert into [dbo].[ScoreConfig] ([Name], [PaperNumber], [PublishNumber], [Creator], [Created],[Enabled],[Guid])
		select [Name], @newPaperNumber, @publishNumber, [Creator], getdate(), 1, @newConfigGuid
		from [ScoreConfig] where [Number] = @configNumber

		insert into @copyConfig ([numberFrom],[toNumber])
		select @configNumber as [numberFrom], scope_identity() as [toNumber]

		delete from @temp where [ConfigNumber] = @configNumber
	end
	commit tran TConfig

	--//

	exec sp_Question_CopyAll @paperNumber=@paperNumber, @newPaperNumber=@newPaperNumber,@copyConfig=@copyConfig
	--exec sp_ScoreConfig_CopyAll @paperNumber, @newPaperNumber, 0

	commit tran TPaper
END
