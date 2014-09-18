-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SurveyTarget_RemoveGroupMember
	-- Add the parameters for the stored procedure here
	@surveyNumber int
	,@groupId varchar(20)
	,@memberId varchar(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from TargetGroupMember where SurveyNumber = @surveyNumber and GroupId = @groupId and MemberId = @memberId

END
