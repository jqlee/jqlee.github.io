
Create PROCEDURE [dbo].[sp_TargetDepartmentGroup_DeleteByGroup]
	@groupId varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[TargetDepartmentGroup] 
	where [GroupId] = @groupId
END
