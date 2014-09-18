
CREATE PROCEDURE [dbo].[sp_ChoiceScore_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [ConfigNumber], [ChoiceNumber], [Score]
	FROM [dbo].[ChoiceScore]
	where [Number] = @number
END

