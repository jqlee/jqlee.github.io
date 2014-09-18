-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	為了複製翻譯文字，將此功能提出製成獨立程序
-- =============================================
CREATE PROCEDURE [dbo].[sp_Subset_CopyByQuestion]
	-- Add the parameters for the stored procedure here
	@questionNumber int
	,@newQuestionNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @temp Table ([Idx] int identity(1,1),[Number] int, [Done] bit)
	insert into @temp ([Number],[Done])
	select [Number],0 from [Subset] where QuestionNumber = @questionNumber


	declare @current int
	declare @currentValue int
	declare @guid uniqueidentifier
	--print 'Run copy subset'
	while (exists(select 0 from @temp where Done = 0))
	begin
		set @guid = newid();
		select @current = [Idx] from @temp where Done = 0
		select @currentValue = [Number] from @temp where Idx = @current
		update @temp set [Done] = 1 where Idx = @current
		--print @currentValue
	
		exec sp_Subset_CopyOne @number=@currentValue,@newQuestionNumber=@newQuestionNumber
		/*
		select pt.[LangNumber], pt.[CategoryNumber], s.[Number] as [DataNumber], pt.[DataValue] 
		from [dbo].[Subset] s
		inner join PaperLanguageText pt  on s.[Number] = pt.[DataNumber]
		inner join PaperLanguageCategory pc on pc.Number = pt.CategoryNumber and pc.Name in ('subset','grouping')
		where pt.[DataNumber] = 2502	
		*/
	end

    -- Insert statements for procedure here
	/*
	insert into [dbo].[Subset] ([Dimension],[QuestionNumber],[Text],[SortOrder])
	select [Dimension],@newQuestionNumber,[Text],[SortOrder] 
	from [dbo].[Subset] 
	where [QuestionNumber] = @questionNumber


	*/
END
/*
declare @questionNumber int = 647
declare @newQuestionNumber int = 9999
--clear 
delete from [Subset] where QuestionNumber = @newQuestionNumber
select * from [Subset] where QuestionNumber = @questionNumber
exec sp_Subset_CopyByQuestion @questionNumber, @newQuestionNumber
select * from [Subset] where QuestionNumber = @newQuestionNumber

	--select top 10 * from [Subset] order by [Number] desc
	select top 100 * from [PaperLanguageText] order by [Number] desc


delete from PaperLanguageText where DataNumber = 2502 and number > 90

select * from PaperLanguageText where DataNumber = 2502

select * from [Subset] where QuestionNumber = 9999
select * from PaperLanguageText where DataNumber in (2518)

select s.*,pt.*
from [Subset] s
inner join PaperLanguageText pt  on s.[Number] = pt.[DataNumber]
inner join PaperLanguageCategory pc on pc.Number = pt.CategoryNumber and pc.Name in ('subset','grouping')
where s.QuestionNumber = @questionNumber


select pt.*
	from [dbo].[Subset] s
	inner join PaperLanguageText pt  on s.[Number] = pt.[DataNumber]
	inner join PaperLanguageCategory pc on pc.Number = pt.CategoryNumber and pc.Name in ('subset','grouping')
	where pt.[DataNumber] = 2502

select pt.[LangNumber], pt.[CategoryNumber], s.[Number] as [DataNumber], pt.[DataValue] 
	from [dbo].[Subset] s
	inner join PaperLanguageText pt  on s.[Number] = pt.[DataNumber]
	inner join PaperLanguageCategory pc on pc.Number = pt.CategoryNumber and pc.Name in ('subset','grouping')
	where pt.[DataNumber] = 2502
*/