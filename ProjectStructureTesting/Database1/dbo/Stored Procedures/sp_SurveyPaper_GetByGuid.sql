-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyPaper_GetByGuid]
	-- Add the parameters for the stored procedure here
	@guid uniqueidentifier
	,@langNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT isNull(lt.DataValue,p.[Title]) as [LangTitle]
	, isNull(ld.DataValue,p.[Description]) as [LangDescription]
	, p.* 
	from SurveyPaper p
	left outer join (
		select plt.DataNumber,plt.DataValue
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plt.[LangNumber] = @langNumber and plc.[Name] = 'papertitle'
	) lt on lt.DataNumber = p.Number
	left outer join (
		select plt.DataNumber,plt.DataValue
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plt.[LangNumber] = @langNumber and plc.[Name] = 'paperdesc'
	) ld on ld.DataNumber = p.Number
	where p.[Guid] = @guid


END

--select * from PaperLanguageText