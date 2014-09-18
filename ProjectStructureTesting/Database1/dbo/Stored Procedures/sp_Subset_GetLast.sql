
Create PROCEDURE [dbo].[sp_Subset_GetLast]
	@dimension int = 0
	,@questionId uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 s.[Number], s.[Dimension], s.[QuestionNumber], s.[Text], s.[SortOrder]
	FROM [Question] q 
	inner join [dbo].[Subset] s on s.QuestionNumber = q.Number and s.[Dimension] = @dimension
	where q.[Guid] = @questionId
	order by s.[Number] desc
END

