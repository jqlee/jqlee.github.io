
Create PROCEDURE [dbo].[sp_Subset_GetListByQuestionId]
	@dimension int = 0
	,@questionId uniqueidentifier
AS
BEGIN
	/*v1*/
	SET NOCOUNT ON;
	SELECT isNull(ss.Number,0) as [Number], ss.[Dimension], ss.[QuestionNumber], ss.[Text], ss.[SortOrder]
	from Question q
	inner join subset ss on ss.QuestionNumber = q.Number
	where q.Guid = @questionId and ss.Dimension = @dimension
	order by ss.SortOrder
	

	/*v2
	SELECT isNull(ss.Number,0) as [Number], ss.[Dimension], ss.[QuestionNumber], ss.[Text], ss.[SortOrder]
	from question q
	left outer join subset ss on ss.QuestionNumber = q.Number
	where q.Number = @questionNumber and ss.Dimension = @dimension
	order by ss.SortOrder
	*/
END
