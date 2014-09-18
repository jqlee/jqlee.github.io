-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
Create PROCEDURE [dbo].[sp_Member_GetGroupMembers]
	-- Add the parameters for the stored procedure here
	@groupId varchar(20) = null
	,@roleCode varchar(6) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select m.* 
	from v_Member m
	inner join v_GroupMember gm on gm.MemberId = m.Id
	where gm.GroupId = @groupId and gm.RoleCode = @roleCode
END
