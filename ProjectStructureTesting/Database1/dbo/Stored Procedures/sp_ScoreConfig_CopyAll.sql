-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreConfig_CopyAll]
	-- Add the parameters for the stored procedure here
	@paperNumber int
	,@newPaperNumber int
	,@targetIsTemplate bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	declare @temp Table ([Number] int identity(1,1), [ConfigNumber] int)
	insert into @temp ([ConfigNumber])
	SELECT [Number] as [ConfigNumber] from [dbo].[ScoreConfig] where [PaperNumber] = @paperNumber;

	begin tran T1

	declare @currentNumber int
	while (exists(select 0 from @temp))
	begin
		select @currentNumber = [ConfigNumber] from @temp
		--print @currentQuestion;
		exec sp_ScoreConfig_Copy @configNumber = @currentNumber ,@newPaperNumber = @newPaperNumber, @targetIsTemplate = @targetIsTemplate
		delete from @temp where [ConfigNumber] = @currentNumber
	end

	commit tran T1
	
END
