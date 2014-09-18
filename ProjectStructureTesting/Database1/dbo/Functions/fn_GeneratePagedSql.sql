CREATE FUNCTION [dbo].[fn_GeneratePagedSql] (
	@tableName nvarchar(max)
	, @tableColumns nvarchar(max)
	, @sortExpression nvarchar(max)
	, @whereConditions nvarchar(max) = null
) RETURNS nvarchar(max)
AS
BEGIN
	DECLARE @sql nvarchar(max);
	DECLARE @IntValue nvarchar(max);
	DECLARE @ParmDefinition NVARCHAR(max);
	SET @ParmDefinition = N'@startRowIndex int,@maximumRows int , @recordCount int output';

	--if (@whereConditions is null or LTRIM(RTRIM(@whereConditions)) = '') set @whereConditions = '1>0'
	
	RETURN N'
    SET NOCOUNT ON;
	begin
		SELECT @recordCount = COUNT(*) 
		FROM '+ @tableName+N'
		'+ @whereConditions+N'
	end

	BEGIN
		with [TempTable] as (
			Select ROW_NUMBER() OVER (ORDER BY '+@sortExpression+N') AS [RowNumber]
				,'+@tableColumns+N'
			from '+ @tableName+N'
			'+ @whereConditions+N'
		)
		SELECT *
		FROM [TempTable]
		WHERE [RowNumber] between @startRowIndex+1 and @startRowIndex+@maximumRows
	end;
	'
END
		
