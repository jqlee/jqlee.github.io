
CREATE PROCEDURE [dbo].[sp_Subset_GetList]
	@dimension int = 0
	,@questionNumber int = 0
	,@langNumber int = 0
AS
BEGIN
	/*v1*/
	SET NOCOUNT ON;

	declare @category varchar(10)
	set @category = case @dimension when 1 then 'subset' else 'grouping' end


	SELECT isNull(l.DataValue, ss.[Text]) as [LangText]
	,isNull(ss.Number,0) as [Number], ss.[Dimension], ss.[QuestionNumber], ss.[Text], ss.[SortOrder]
	from [Subset] ss
	left outer join (
		select plt.DataNumber,plt.DataValue
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plt.[LangNumber] = @langNumber and plc.[Name] = @category
	) l on l.DataNumber = ss.Number
	where ss.QuestionNumber = @questionNumber and ss.Dimension = @dimension
	order by ss.SortOrder
	

	/*v2
	SELECT isNull(ss.Number,0) as [Number], ss.[Dimension], ss.[QuestionNumber], ss.[Text], ss.[SortOrder]
	from question q
	left outer join subset ss on ss.QuestionNumber = q.Number
	where q.Number = @questionNumber and ss.Dimension = @dimension
	order by ss.SortOrder
	*/
END
/*
declare 	@dimension int = 0
	,@questionNumber int = 0
	,@langNumber int = 0
declare @category varchar(10)
	set @category = case @dimension when 1 then 'subset' else 'grouping' end
select * from [Subset]
*/