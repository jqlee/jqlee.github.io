
CREATE PROCEDURE [dbo].[sp_ViewPermission_DeleteOne]
	@publishNumber int
	,@questionNumber int
	,@subsetNumber int
	,@groupingNumber int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[ViewPermission] 
	where [PublishNumber] = @publishNumber
	 and [QuestionNumber] = @questionNumber
	 and [SubsetNumber] = @subsetNumber
	 and [GroupingNumber] = @groupingNumber
END

 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ViewPermission_DeleteAll')
   exec('CREATE PROCEDURE [dbo].[sp_ViewPermission_DeleteAll] AS BEGIN SET NOCOUNT ON; END')
