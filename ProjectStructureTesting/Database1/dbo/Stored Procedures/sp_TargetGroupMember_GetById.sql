
CREATE PROCEDURE [dbo].[sp_TargetGroupMember_GetById]
	@surveyNumber int = null
	,@groupId varchar(20) = null
	,@memberId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [SurveyNumber], [GroupId], [MemberId], [Name]
	FROM [dbo].[TargetGroupMember]
	where [SurveyNumber] = @surveyNumber
	 and [GroupId] = @groupId
	 and [MemberId] = @memberId
END


