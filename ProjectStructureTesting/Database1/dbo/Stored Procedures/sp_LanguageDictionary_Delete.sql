
CREATE PROCEDURE [dbo].[sp_LanguageDictionary_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[LanguageDictionary] where [Number] = @number
END