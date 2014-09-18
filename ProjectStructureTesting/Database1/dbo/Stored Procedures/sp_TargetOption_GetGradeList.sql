-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TargetOption_GetGradeList]
	-- Add the parameters for the stored procedure here
	@departmentId varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select Convert(tinyint, 4) as [Mark]
		,Convert(int,g.Value) as Value
		,g.Name
		,0 as ItemCount
	from fnGetGradeList() g
	order by g.Value



    -- Insert statements for procedure here
	/*
	select Convert(tinyint, 4) as [Mark]
		, isNull(Convert(int,g.Value), x.Value) as Value
		,isNull(g.Name, x.Value) as [Name]
		,isNull(x.MemberCount,0) as ItemCount
	from fnGetGradeList() g
	full outer join (
		SELECT Grade as Value,count(*) as MemberCount 
		from v_Member m
		where 
		DepartmentId = isNull(@departmentId, DepartmentId) 
		and m.[Enabled] = 1 and m.[BasicRoleValue] = 10
		and Grade is not null
		group by Grade
	) x on x.Value = g.Value
	
	order by  isNull(Convert(int,g.Value), x.Value)
	*/
END