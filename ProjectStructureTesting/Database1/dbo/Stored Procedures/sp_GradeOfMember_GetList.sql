-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GradeOfMember_GetList]
	-- Add the parameters for the stored procedure here
	@departmentId varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
    -- Insert statements for procedure here
	SELECT Grade as Value,count(*) as MemberCount 
	from v_Member 
	where DepartmentId = isNull(@departmentId,DepartmentId)
	and Grade is not null
	group by Grade
	order by Grade
	*/
	

select Convert(int,g.Value) as Value,g.Name,isNull(x.MemberCount,0) as ItemCount
from fnGetGradeList() g
left outer join (
	SELECT Grade as Value,count(*) as MemberCount 
	from v_Member 
	where DepartmentId = isNull(@departmentId, DepartmentId) and Grade is not null
	group by Grade
) x on x.Value = g.Value

END
