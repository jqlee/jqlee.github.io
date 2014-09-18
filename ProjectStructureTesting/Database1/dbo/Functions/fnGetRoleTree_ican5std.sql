-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetRoleTree_ican5std]
(	
	-- Add the parameters for the function here
	@man_no varchar(20)
)
RETURNS @temp Table ([DepartmentId] varchar(8), [ParentId] varchar(8), [DepartmentName] nvarchar(50), [Depth] int, [Path] varchar(max), [Root] varchar(8))

begin
	-- Add the SELECT statement with parameter references here
	
	--declare @temp Table ([coll_no] varchar(8), [up_coll] varchar(8), [coll_name] nvarchar(50), [Depth] int, [Path] varchar(max), [Root] varchar(8))

	;WITH Hierarchies([DepartmentId], [ParentId], [DepartmentName], [Depth], [Path], [Root]) AS
	(
		SELECT [coll_no] as [DepartmentId], [up_coll] as [ParentId], [coll_name] as [DepartmentName], 0 AS [Depth], convert(varchar(max),isNull([coll_no],'')) as [Path], [coll_no] as [Root]
		 FROM iCAN5_STD.dbo.college  Where [up_coll] is null
	UNION ALL
		SELECT e.[coll_no] as [DepartmentId],e.[up_coll], e.[coll_name], h.[Depth] + 1 AS [Depth], convert(varchar(max),h.[Path] +'.'+ e.[coll_no]) as [Path], h.[Root]
		 FROM iCAN5_STD.dbo.college e 
		 INNER JOIN Hierarchies h ON e.[up_coll] = h.[DepartmentId] 
	)

	insert into @temp
	select h.* from Hierarchies h
	inner join iCAN5_STD.dbo.udf_GetPermCollsWithSAOOA(@man_no) p on p.[coll_no] = h.[DepartmentId]
	
	--權限樹
	--select * from @temp order by [path];
	return;
end
