-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnDepartmentList
(	
	-- Add the parameters for the function here
	@keyword varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select [DepartmentId] ,[ParentId] ,[DepartmentName] ,[Depth] ,[Path] ,[Root] ,[ChildrenCount] 
	from dbo.fnGetTreeFromDepartment(@keyword) where ChildrenCount = 0 and [Enabled] = 1
 
)
