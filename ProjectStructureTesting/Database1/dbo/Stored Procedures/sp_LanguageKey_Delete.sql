
CREATE PROCEDURE [dbo].[sp_LanguageKey_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[LanguageKey] where [Number] = @number
END