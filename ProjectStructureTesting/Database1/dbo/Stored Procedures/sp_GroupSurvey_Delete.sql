-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_GroupSurvey_Delete
	-- Add the parameters for the stored procedure here
	@groupId varchar(20) = null
	,@surveyNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	Delete from GroupSurvey where GroupId = @groupId and SurveyNumber = @surveyNumber

END
