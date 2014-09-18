-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyTarget_GetGroupMembers]
	-- Add the parameters for the stored procedure here
		@surveyNumber int
	,@groupId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT t.Number, t.SurveyNumber, t.MemberId as TargetTag, t.Name as TargetName 
	from TargetGroupMember t
	where t.SurveyNumber = @surveyNumber and t.GroupId = @groupId
END
