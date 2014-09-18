
CREATE PROCEDURE [dbo].[sp_Course_GetPagedList]
	@name nvarchar(100) = null
	,@collegeId varchar(20) = null
	,@year int = null 
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	--若參數型別對應到.net的實值型別，並且參數允許null，請務必檢查is null並給預設值
	--if (@int is null) set @int = -1; 

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'[Course]' --table
	, '[Id], [Name], [CollegeId], [Year]' --reutrn columns
	, '[Id]' --sortExpressions
	, 'where [Name] = isNull(@name,[Name])
	 and [CollegeId] = isNull(@collegeId,[CollegeId])
	 and [Year] = isNull(@year,[Year])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@name nvarchar(100), @collegeId varchar(20), @year int,@startRowIndex int,@maximumRows int , @recordCount int output'
		,@name=@name , @collegeId=@collegeId , @year=@year ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END


