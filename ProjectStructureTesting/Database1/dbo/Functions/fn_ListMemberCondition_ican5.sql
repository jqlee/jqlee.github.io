-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fn_ListMemberCondition_ican5
(	
	-- Add the parameters for the function here
	@departmentId varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select m.*,p.RoleName,p.RoleOrder  from (
	select m.man_coll as DepartmentId,m.man_user as RoleId,m.man_grade as Grade,count(*) as MemberCount
	from ican5.dbo.man m
	where m.man_coll = @departmentId
	group by m.man_coll,m.man_user,m.man_grade
)m inner join (
	select para_phsiname as RoleId, para_dispname as RoleName, para_no as RoleOrder
	from ican5.dbo.ican_para where para_code = 'p_user'
) p
on p.RoleId = m.RoleId

)
