-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [sp_Member_GetListBygroupId]
	-- Add the parameters for the stored procedure here
	@groupId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select gm.GroupId, gm.IsMaster,gm.IsAudit, m.* from v_GroupMember gm
	inner join v_MemberWithDepartment m on m.Id = gm.MemberId
	where gm.GroupId = @groupId

END
