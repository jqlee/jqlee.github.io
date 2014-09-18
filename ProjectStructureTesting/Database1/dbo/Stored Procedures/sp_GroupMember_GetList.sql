-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_GroupMember_GetList
	-- Add the parameters for the stored procedure here
	@groupId varchar(20) = null
	,@memberId varchar(20) = null
	,@groupRoleValue tinyint = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from v_GroupMember 
	where GroupId = isNull(@groupId,GroupId)
	 and MemberId = isNull(@memberId,MemberId)
	 and GroupRoleValue = isNull(@groupRoleValue,GroupRoleValue)
END
