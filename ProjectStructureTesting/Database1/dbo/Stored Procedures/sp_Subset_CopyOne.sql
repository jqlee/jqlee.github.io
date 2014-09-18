-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Subset 包含子題與群組，複製時須同時複製翻譯字串
-- =============================================
CREATE PROCEDURE sp_Subset_CopyOne
	-- Add the parameters for the stored procedure here
	@number int
	,@newQuestionNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	begin tran t1

	declare @guid uniqueidentifier = newid()

	insert into [dbo].[Subset] ([Dimension],[QuestionNumber],[Text],[SortOrder],[Guid])
	select [Dimension],@newQuestionNumber,[Text],[SortOrder], @guid
	from [dbo].[Subset] 
	where [Number] = @number

	--print @guid
	-- copy translation
	-- subset grouping
	declare @newNumber int
	select @newNumber = [Number] from [dbo].[Subset] where [Guid] = @guid
	/*


	select pt.* from PaperLanguageCategory pc
	inner join PaperLanguageText pt on pt.CategoryNumber = pc.Number
	where pc.Name in ('subset','grouping')

	select * from PaperLanguageText where DataNumber = @number
	*/

	/*
	insert into PaperLanguageText ([LangNumber], [CategoryNumber], [DataNumber], [DataValue])
	select pt.[LangNumber], pt.[CategoryNumber], @newNumber as [DataNumber], pt.[DataValue] 
	from PaperLanguageText pt
	inner join PaperLanguageCategory pc on pc.Number = pt.CategoryNumber and pc.Name in ('subset','grouping')
	where pt.[DataNumber] = @number
	*/
	exec sp_Translation_Copy @category='subset',@dataNumber=@number,@newDataNumber=@newNumber
	exec sp_Translation_Copy @category='grouping',@dataNumber=@number,@newDataNumber=@newNumber

	commit tran t1
END
