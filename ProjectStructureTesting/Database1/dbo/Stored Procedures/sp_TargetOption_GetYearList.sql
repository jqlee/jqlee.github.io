-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TargetOption_GetYearList]
-- Add the parameters for the stored procedure here
	@departmentId varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select Convert(tinyint, 3) as [Mark], x.GroupYear as [Value] 
	, Convert(varchar, GroupYear) as Name, 0 as [ItemCount]
	from (
		select distinct GroupYear from v_DepartmentGroup
	) x
	 order by x.GroupYear
	/*
    -- Insert statements for procedure here
	select Convert(tinyint, 3) as [Mark], GroupYear as [Value], Convert(varchar, GroupYear) as Name, count(distinct g.Id) as [ItemCount]
	from v_DepartmentGroup g
		inner join v_GroupMember gm on gm.GroupId = g.Id and gm.GroupRoleValue=10 and gm.MemberId is not null and gm.[Enabled] = 1
		--要有學生才算有
	where DepartmentId = isNull(@departmentId, DepartmentId)
	group by GroupYear 
	order by GroupYear

	*/
END
