-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyStatus_GetList]
	-- Add the parameters for the stored procedure here
	@surveyId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if (@surveyId = '00000000-0000-0000-0000-000000000000') set @surveyId = null;
	select ss.* 
	,ps.PeriodYear,ps.PeriodSeme
	,ps.Name,ps.Description, ps.OpenDate, ps.CloseDate, ps.QueryDate
	from v_SurveyStatus ss
	inner join PublishSetting ps on ps.Number = ss.PublishNumber --ps.[Guid] = ss.SurveyId

	where ps.[Guid] = isNull(@surveyId, ps.[Guid])
	
	/*
	select SurveyId,SurveyNumber
	,sum(case when RecordNumber is not null then 1 else 0 end) as RecordCount
	,sum(case when RecordDone = 1 then 1 else 0 end) as CompleteCount
	,count(MemberId) as TotalCount
	from v_SurveyMatch 
	where SurveyId = isNull(@surveyId, SurveyId)
	group by SurveyId,SurveyNumber
	*/
END

/*
exec sp_SurveyStatus_GetList '843f5462-640d-40b8-8bd8-bc4e6b9d54d2'

*/