-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[del_sp_Choice_GetStatByQuestionAndLog]
	-- Add the parameters for the stored procedure here
	@questionNumber int = 0
	,@subsetNumber int = 0
	,@groupingNumber int = 0
	,@logNumber int = 0
	,@matchKey varchar(100) = null
	--,@matchFilter int = -1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--if (@matchFilter = -1) set @matchFilter = null;

    -- Insert statements for procedure here

	declare @configNumber int
	select @configNumber = ConfigNumber from ScoreLog where Number = @logNumber

	select dbo.fnPadLeft(c.SortOrder,3,'0') as AutoId, q.FullTitle ,x.*, c.Number, c.[Text], c.SortOrder 
	,cs.Score as ChoiceScore
	from 
	v_QuestionUnit q
	inner join Choice c on c.QuestionNumber = q.QuestionNumber
	inner join ChoiceScore cs on cs.ChoiceNumber = c.Number and cs.ConfigNumber = @configNumber
	left outer join 
	(
		select  q.Section, q.QuestionNumber, q.SubsetNumber, q.GroupingNumber, c.Number as ChoiceNumber
		,sum(isNull(s.ChooseCount,0)) as MemberCount
		from v_QuestionUnit q
		inner join Choice c on c.QuestionNumber = q.QuestionNumber
		left outer join dbo.fnLoggedQuestionStat(@logNumber,@questionNumber,@subsetNumber,@groupingNumber) s 
		--left outer join dbo.fnCurrentQuestionStat(@questionNumber,@subsetNumber,@groupingNumber) s 
			on s.QuestionNumber = q.QuestionNumber and s.SubsetNumber = q.SubsetNumber and s.GroupingNumber = q.GroupingNumber
			and s.ChoiceNumber = c.Number
		where q.questionNumber = @questionNumber and q.subsetNumber = @subsetNumber and q.GroupingNumber = @groupingNumber
		and s.MatchKey = isNull(@matchKey,s.MatchKey) --and s.MatchFilter = isNull(@matchFilter,s.MatchFilter)
		group by q.AutoId, q.Section, q.QuestionNumber, q.SubsetNumber, q.GroupingNumber, c.Number
		,q.Section, q.SortOrder, q.SubsetSort, q.GroupingSort, c.SortOrder
	) x 
	 on x.ChoiceNumber = c.Number and x.QuestionNumber = c.QuestionNumber and x.SubsetNumber = q.SubsetNumber and x.GroupingNumber = q.GroupingNumber
	where c.QuestionNumber = @questionNumber and q.subsetNumber = @subsetNumber and q.GroupingNumber = @groupingNumber
	order by c.SortOrder
END
