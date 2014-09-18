
CREATE PROCEDURE [dbo].[sp_TargetGroupMember_Delete]
	@surveyNumber int
	,@groupId varchar(20)
	,@memberId varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetGroupMember] where [SurveyNumber] = @surveyNumber
	 and [GroupId] = @groupId
	 and [MemberId] = @memberId
END
