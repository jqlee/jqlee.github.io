
CREATE PROCEDURE [dbo].[sp_Survey_GetListForGroup]
	@groupId varchar(20) = null
	,@stateMark tinyint = null
	,@visible bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	if (@stateMark = 0) set @stateMark = null;

	select null as [CurrentUser], m.Name as [OwnerName], s.* from Survey s
	inner join v_Member m on m.Id = s.Owner
	where s.GroupOnly = @visible and s.GroupId = @groupId 
	 and s.[StateMark] = isNull(@stateMark,s.[StateMark])
	 and s.Visible = @visible
	/*
	SELECT [Number], [Name], [Title], [GroupOnly], [GroupId], [Description], [IsEnableHtml], [StartDate], [EndDate], [TotalReturn], [ResultOpen], [PageCount], [StateMark], [Enabled], [Creator], [Created], [CreatorName], [LastModified], [LastModifier], [LastModifierName], [CanAnswerTimes], [Language], [Guid], [CreateItemType], [CreateItemNumber]
	FROM [dbo].[Survey]
	where [Creator] = isNull(@creator,[Creator])
	 and [StateMark] = isNull(@stateMark,[StateMark])
	*/

END

