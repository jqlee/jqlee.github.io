-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_QuestionStruct_GetById
	-- Add the parameters for the stored procedure here
	@questionNumber int
AS
BEGIN
	SET NOCOUNT ON;

	select isNull(SubsetNumber,0) as SubsetNumber, SubsetText ,IsVerticalDirection,ChooseMax
	, isNull([1],0) as [Group1], isNull([2],0) as [Group2], isNull([3],0) as [Group3], isNull([4],0) as [Group4], isNull([5],0) as [Group5]
	from
	(
		select 
				isNull(ss.Number,0) as SubsetNumber
				,ss.[Text] as SubsetText
				,isNull(sg.Number,0) as GroupingNumber
				,ss.SortOrder
				,q.IsVerticalDirection
				,q.ChooseMax
				,row_number() over (partition by q.Number, ss.Number order by sg.SortOrder) rn
		from Question q
		left outer join [Subset] ss on ss.QuestionNumber = q.Number and ss.Dimension = 1
		left outer join [Subset] sg on sg.QuestionNumber = q.Number and sg.Dimension = 2
		where q.Number = @questionNumber
	) s
	pivot (min (GroupingNumber) for rn in ([1], [2], [3], [4], [5])) pvt
		order by SortOrder


END
