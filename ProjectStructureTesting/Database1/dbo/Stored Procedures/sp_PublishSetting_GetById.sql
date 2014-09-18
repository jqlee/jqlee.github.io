
CREATE PROCEDURE [dbo].[sp_PublishSetting_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1
	ps.* --[Number], [Period], [Name], [Description], [TargetMark], [SurveyNumber], [DoneMessage], [OpenDate], [CloseDate], [QueryDate], [LastModified], [Creator], [IsVerified], [VerifierId], [VerifierName]
	FROM [dbo].[PublishSetting] ps
	where ps.[Number] = @number
END

