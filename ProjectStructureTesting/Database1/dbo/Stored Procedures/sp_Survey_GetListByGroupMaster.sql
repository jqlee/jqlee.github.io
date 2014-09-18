
CREATE PROCEDURE [dbo].[sp_Survey_GetListByGroupMaster]
	@masterId nvarchar(20) = null
	,@groupId nvarchar(20) = null
	,@stateMark tinyint = 0
AS
BEGIN
	SET NOCOUNT ON;
	if (@stateMark = 0) set @stateMark = null;

	select x.*, m.Note as [StateNote] from (
		SELECT s.[Number], s.[Name], s.[Title], s.[GroupOnly], s.[GroupId], s.[Description], s.[IsEnableHtml], s.[StartDate], s.[EndDate], s.[TotalReturn], s.[ResultOpen], s.[PageCount], s.[StateMark], s.[Enabled], s.[Creator], s.[Created], s.[CreatorName],s. [LastModified], s.[LastModifier], s.[LastModifierName], s.[CanAnswerTimes], s.[Language], s.[Guid], s.[CreateItemType], s.[CreateItemNumber]
		FROM [dbo].[Survey] s
		inner join [dbo].[TargetDepartmentGroup] g on g.SurveyNumber = s.Number and g.GroupId = @groupId
		where s.[GroupOnly] = 1 and s.[Creator] = @masterId and s.[StateMark] = ISNULL(@stateMark, s.[StateMark])
		union
		SELECT s.[Number], s.[Name], s.[Title], s.[GroupOnly], s.[GroupId], s.[Description], s.[IsEnableHtml], s.[StartDate], s.[EndDate], s.[TotalReturn], s.[ResultOpen], s.[PageCount], s.[StateMark], s.[Enabled], s.[Creator], s.[Created], s.[CreatorName],s. [LastModified], s.[LastModifier], s.[LastModifierName], s.[CanAnswerTimes], s.[Language], s.[Guid], s.[CreateItemType], s.[CreateItemNumber]
		FROM [dbo].[Survey] s
		inner join [dbo].[TargetGroupMember] g on g.SurveyNumber = s.Number and g.GroupId = @groupId
		where s.[GroupOnly] = 1 and s.[Creator] = @masterId and s.[StateMark] = ISNULL(@stateMark, s.[StateMark])
	) x left outer join [SysMark] m on m.Name='GroupStateMark' and m.Value = x.StateMark
	order by ISNULL([LastModified], [Created]) desc
END

