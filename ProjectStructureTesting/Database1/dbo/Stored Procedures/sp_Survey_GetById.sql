
CREATE PROCEDURE [dbo].[sp_Survey_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 * -- [Number], [Name], [Title], [GroupOnly], [GroupId], [Description], [IsEnableHtml], [StartDate], [EndDate], [TotalReturn], [ResultOpen], [PageCount], [StateMark], [Enabled], [Creator], [Created], [CreatorName], [LastModified], [LastModifier], [LastModifierName], [CanAnswerTimes], [Language], [Guid], [CreateItemType], [CreateItemNumber]
	FROM [dbo].[Survey]
	where [Number] = @number
END


