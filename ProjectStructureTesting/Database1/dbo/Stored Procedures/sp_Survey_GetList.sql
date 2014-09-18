
CREATE PROCEDURE [dbo].[sp_Survey_GetList]
	@creator varchar(20) = null
	,@stateMark tinyint = 1
AS
BEGIN
	SET NOCOUNT ON;
	if (@stateMark = 0) set @stateMark = null;

	SELECT * --[Number], [Name], [Title], [GroupOnly], [GroupId], [Description], [IsEnableHtml], [StartDate], [EndDate], [TotalReturn], [ResultOpen], [PageCount], [StateMark], [Enabled], [Creator], [Created], [CreatorName], [LastModified], [LastModifier], [LastModifierName], [CanAnswerTimes], [Language], [Guid], [CreateItemType], [CreateItemNumber]
	FROM [dbo].[Survey]
	where [Creator] = isNull(@creator,[Creator])
	 and [StateMark] = isNull(@stateMark,[StateMark])
END

