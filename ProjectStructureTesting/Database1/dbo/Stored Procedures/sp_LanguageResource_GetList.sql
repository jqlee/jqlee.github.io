
CREATE PROCEDURE [dbo].[sp_LanguageResource_GetList]
	@done bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [FileName], [XmlContent], [Done]
	FROM [dbo].[LanguageResource]
	where [Done] = @done
END
