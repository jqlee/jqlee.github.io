-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_GroupSurvey_Save
	-- Add the parameters for the stored procedure here
	@groupId varchar(20) = null
	,@surveyNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	if (not exists(select 0 from GroupSurvey where GroupId = @groupId and SurveyNumber = @surveyNumber))
		insert into GroupSurvey (GroupId, SurveyNumber) Values (@groupId, @surveyNumber)

END
