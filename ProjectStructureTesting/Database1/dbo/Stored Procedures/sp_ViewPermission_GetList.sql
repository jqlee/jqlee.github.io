
CREATE PROCEDURE [dbo].[sp_ViewPermission_GetList]
	@publishNumber int = 0
	
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [PublishNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber]
	FROM [dbo].[ViewPermission]
	where [PublishNumber] = @publishNumber
END
