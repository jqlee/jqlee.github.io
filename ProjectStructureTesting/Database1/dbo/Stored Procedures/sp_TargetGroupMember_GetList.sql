
CREATE PROCEDURE [dbo].[sp_TargetGroupMember_GetList]
	
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [SurveyNumber], [GroupId], [MemberId], [Name]
	FROM [dbo].[TargetGroupMember]
	 
END

