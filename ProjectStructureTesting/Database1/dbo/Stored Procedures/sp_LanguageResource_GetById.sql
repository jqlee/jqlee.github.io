
CREATE PROCEDURE [dbo].[sp_LanguageResource_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [FileName], [XmlContent], [Done]
	FROM [dbo].[LanguageResource]
	where [Number] = @number
END

