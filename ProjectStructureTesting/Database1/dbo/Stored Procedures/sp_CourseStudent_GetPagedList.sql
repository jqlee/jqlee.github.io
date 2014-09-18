
CREATE PROCEDURE [dbo].[sp_CourseStudent_GetPagedList]
	@isAudit bit = null 
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
	'[CourseStudent]' --table
	, '[StudentId], [CourseId], [IsAudit]' --reutrn columns
	, '[StudentId], [CourseId]' --sortExpressions
	, 'where [IsAudit] = isNull(@isAudit,[IsAudit])' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@isAudit bit,@startRowIndex int,@maximumRows int , @recordCount int output'
		,@isAudit=@isAudit ,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END


