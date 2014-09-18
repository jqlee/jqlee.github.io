-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_YearOfGroup_GetList]
	-- Add the parameters for the stored procedure here
	@departmentId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/**/

	    -- Insert statements for procedure here
	select GroupYear as [Value],count(distinct g.Id) as ItemCount 
	from v_DepartmentGroup g
		inner join v_GroupMember gm on gm.GroupId = g.Id and gm.GroupRoleValue=10 and gm.MemberId is not null and gm.[Enabled] = 1
		--要有學生才算有
	where DepartmentId = isNull(@departmentId, DepartmentId)
	group by GroupYear 
	order by GroupYear
	

END


