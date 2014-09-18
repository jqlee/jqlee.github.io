
CREATE PROCEDURE [dbo].[sp_LanguageResource_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[LanguageResource] where [Number] = @number
END