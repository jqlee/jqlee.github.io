CREATE PROCEDURE [dbo].[sp_DepartmentTree_GetAvailableListBySurvey]
	-- Add the parameters for the stored procedure here
	@schoolId varchar(10) = null
	,@surveyNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	WITH College_cte AS (

		SELECT SchoolId, Id, Name, ShortName, 1 AS Depth, ParentId, CONVERT(nvarchar(128), Id)  AS SortOrder
        FROM               dbo.v_Department
        WHERE           (ParentId IS NULL) AND (Mark = '10')

        UNION ALL

        SELECT          c.SchoolId, c.Id, c.Name, c.ShortName, cte.Depth + 1 AS Depth, c.ParentId, CONVERT(nvarchar(128), cte.SortOrder + '-' + CONVERT(nvarchar(128), c.Id)) as SortOrder
        FROM              dbo.v_Department AS c INNER JOIN
                                    College_cte AS cte ON c.ParentId = cte.Id
        WHERE          (c.Mark = '10')
		--要做這個判斷，就要連課程的年份以及人員的年級一起考慮進去，所以算了
		--and c.Id not in (select DepartmentId from TargetCondition where SurveyNumber = @surveyNumber)
	)


    SELECT TOP (100) PERCENT 
	REPLICATE('　　', Depth - 1) + '(' + Id + ') ' + Name AS NodeName,Depth,ParentId, SchoolId, Id, Name, ShortName
	, '[' + Id + '] ' + Name AS DisplayName, SortOrder
     FROM               College_cte
	 where SchoolId = isNull(@schoolId,SchoolId) 
	 --基本上最高層不顯示
	 --and ParentId is not null
     ORDER BY    SortOrder
END
