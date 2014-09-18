-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION dbo.fnGetColumnList
(
	-- Add the parameters for the function here
	@tableName NVARCHAR(255) = null, @isIdentity bit = 0
)
RETURNS nvarchar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @o INT, @c NVARCHAR(MAX);

	-- Add the T-SQL statements to compute the return value here

	set @o = OBJECT_ID(@tableName);

	SELECT @c = COALESCE(@c, '') + ',' + QUOTENAME(name)
		FROM sys.columns
		WHERE [object_id] = @o
		AND is_identity = @isIdentity;

	SELECT @c = STUFF(@c, 1, 1, '');

	return @c;

END
