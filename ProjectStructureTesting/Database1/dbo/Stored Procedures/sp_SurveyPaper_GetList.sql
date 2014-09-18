
CREATE PROCEDURE [dbo].[sp_SurveyPaper_GetList]
	@creator varchar(20) = null
	,@enabled bit = 0
	,@isTemplate bit = 0
	,@keyword nvarchar(50) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [Title], [Description], [Enabled], [Creator], [Created], [LastModified], [Guid]
	FROM [dbo].[SurveyPaper]
	where [Creator] = isNull(@creator,[Creator]) and [IsTemplate] = @isTemplate
	and 1 = (case when @enabled is null then 1 when [Enabled] = @enabled then 1 else 0 end)
	and 1 = (case when @keyword is null then 1 when [Title] like '%'+@keyword+'%' or [Description] like '%'+@keyword+'%' then 1 else 0 end)
END
