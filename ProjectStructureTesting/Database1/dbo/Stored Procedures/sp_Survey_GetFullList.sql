
--
-- 20130820: 有問卷管理身分的可以編修所有問卷
--
Create PROCEDURE [dbo].[sp_Survey_GetFullList]
	@stateMark tinyint = 1
AS
BEGIN
	SET NOCOUNT ON;
	if (@stateMark = 0) set @stateMark = null;

	SELECT * --[Number], [Name], [Title], [GroupOnly], [GroupId], [Description], [IsEnableHtml], [StartDate], [EndDate], [TotalReturn], [ResultOpen], [PageCount], [StateMark], [Enabled], [Creator], [Created], [CreatorName], [LastModified], [LastModifier], [LastModifierName], [CanAnswerTimes], [Language], [Guid], [CreateItemType], [CreateItemNumber]
	FROM [dbo].[Survey]
	where [StateMark] = isNull(@stateMark,[StateMark])
END

