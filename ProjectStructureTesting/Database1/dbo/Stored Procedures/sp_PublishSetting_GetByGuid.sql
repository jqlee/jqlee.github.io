
CREATE PROCEDURE [dbo].[sp_PublishSetting_GetByGuid]
	@guid uniqueidentifier = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 st.Title as TemplateTitle, sc.Name as ScoreConfigName, ps.*
	 --[Number], [Period], [Name], [Description], [TargetMark], [SurveyNumber], [DoneMessage], [OpenDate], [CloseDate], [QueryDate], [LastModified], [Creator], [IsVerified], [VerifierId], [VerifierName]
	FROM [dbo].[PublishSetting] ps
	left outer join [SurveyPaper] st on st.[Guid] = ps.TemplateId
	left outer join [ScoreConfig] sc on sc.Number = ps.ScoreConfigNumber
	where ps.[Guid] = @guid
END

