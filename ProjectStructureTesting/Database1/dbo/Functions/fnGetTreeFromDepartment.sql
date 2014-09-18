-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetTreeFromDepartment]
(	
	-- Add the parameters for the function here
	@departmentId varchar(20)

)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	WITH Hierarchies([DepartmentId], [ParentId], [DepartmentName],[Enabled], [Depth], [Path], [Root], [ChildrenCount]) AS
	(
		SELECT [Id] as [DepartmentId], [ParentId], [Name] as [DepartmentName],[Enabled], 0 AS [Depth], convert(varchar(max),isNull([Id],'')) as [Path], [Id] as [Root]
			,[ChildrenCount]
			from v_Department 
			where id = @departmentId
	UNION ALL
		SELECT e.[Id] as [DepartmentId],e.[ParentId], e.[Name],e.[Enabled], h.[Depth] + 1 AS [Depth], convert(varchar(max),h.[Path] +'.'+ e.[Id]) as [Path], h.[Root]
			,e.[ChildrenCount]
			from v_Department e

		 INNER JOIN Hierarchies h ON e.[ParentId] = h.[DepartmentId] 
	)

	select * from Hierarchies -- order by [path]
)
