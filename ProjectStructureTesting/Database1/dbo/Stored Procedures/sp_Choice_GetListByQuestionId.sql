
CREATE PROCEDURE [dbo].[sp_Choice_GetListByQuestionId]
	@questionId uniqueidentifier 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT c.[Number], c.[QuestionNumber], c.[Text], c.[SortOrder], c.[AcceptText], c.[IsJoined]
	FROM [dbo].[Question] q
	inner join [dbo].[Choice] c on c.[QuestionNumber] = q.[Number]
	where q.[Guid] = @questionId
	order by c.[SortOrder]
END

