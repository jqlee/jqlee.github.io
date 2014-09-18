-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SurveyTarget_RemoveGroup
	-- Add the parameters for the stored procedure here
	@surveyNumber int
	,@groupId varchar(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from TargetDepartmentGroup where SurveyNumber = @surveyNumber and GroupId = @groupId

END
