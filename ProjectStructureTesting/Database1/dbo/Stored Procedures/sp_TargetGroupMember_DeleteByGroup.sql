
Create PROCEDURE [dbo].[sp_TargetGroupMember_DeleteByGroup]
	@groupId varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetGroupMember] 
	where [GroupId] = @groupId
END
