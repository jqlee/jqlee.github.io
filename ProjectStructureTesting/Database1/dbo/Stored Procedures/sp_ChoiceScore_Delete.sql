
CREATE PROCEDURE [dbo].[sp_ChoiceScore_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[ChoiceScore] where [Number] = @number
END