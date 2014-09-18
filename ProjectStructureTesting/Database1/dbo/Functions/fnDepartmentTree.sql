-- =============================================
-- Author:		ben
-- Create date: 2012-08-20
-- Description:	查詢 v_Department 指定的資料庫，再與 fnRoleDepartmentList() 合併產生帶有權限欄位的部門樹
--              (回傳的結果需要以[Path]排序)
-- =============================================
CREATE FUNCTION [dbo].[fnDepartmentTree]
(	
	-- Add the parameters for the function here
	@memberId varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
		
	--set @memberId = 'yechen';

	WITH Hierarchies([Id], [ParentId], [Name], [Depth], [Path], [Root]) AS
	(
		SELECT d.[Id] , d.[ParentId], d.[Name], 0 AS [Depth], convert(varchar(max),isNull(d.[Id],'')) as [Path], d.[Id] as [Root]
		 FROM v_Department d
		 inner join v_Member m on m.SchoolId = d.SchoolId 
		  Where m.Id = @memberId and d.[ParentId] is null
	UNION ALL
		SELECT e.[Id],e.[ParentId], e.[Name], h.[Depth] + 1 AS [Depth], convert(varchar(max),h.[Path] +'.'+ e.[Id]) as [Path], h.[Root]
		 FROM v_Department e 
		 INNER JOIN Hierarchies h ON e.[ParentId] = h.[Id] 
	)

	select convert(bit,case when p.man_no is null then 0 else 1 end) as [HasRole]
	, REPLICATE('　　', [Depth]) + '(' + h.[Id] + ') ' + h.[Name] as [NodeName]
	, h.* 
	, (select count(*) from Hierarchies where ParentId = h.Id) as [ChildCount]
	from Hierarchies h
	left outer join ican5.dbo.udf_GetPermCollsWithSAOOA_NoRecursive(@memberId) p on p.[coll_no] = h.[Id]
	--order by [Path]

)
/*
SELECT * FROM fnDepartmentTree('ATCHAO')
*/