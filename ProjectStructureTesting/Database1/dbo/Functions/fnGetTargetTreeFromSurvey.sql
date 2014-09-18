-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetTargetTreeFromSurvey]
(	
	-- Add the parameters for the function here
	@surveyNumber int

)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	WITH Hierarchies([DepartmentId], [ParentId], [DepartmentName],[Enabled], [Depth], [Path], [Root]) AS
	(
		SELECT d.[Id] as [DepartmentId], d.[ParentId], d.[Name] as [DepartmentName],d.[Enabled], 0 AS [Depth], convert(varchar(max),isNull(d.[Id],'')) as [Path], d.[Id] as [Root]
			from TargetForDepartment t
			inner join v_Department d on d.Id = isNull(t.DepartmentId, d.Id)
			where t.SurveyNumber = @surveyNumber
	UNION ALL
		SELECT e.[Id] as [DepartmentId],e.[ParentId], e.[Name],e.[Enabled], h.[Depth] + 1 AS [Depth], convert(varchar(max),h.[Path] +'.'+ e.[Id]) as [Path], h.[Root]
			from v_Department e

		 INNER JOIN Hierarchies h ON e.[ParentId] = h.[DepartmentId] 
	)

	select * from Hierarchies -- order by [path]
)
