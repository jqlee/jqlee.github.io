-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetColumnListWithType]
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

	SELECT @c = COALESCE(@c, '') + ',' + QUOTENAME(c.name)
	 +' ' + (t.name + case when t.name = 'char' or t.name = 'varchar' or t.name = 'nchar' or t.name = 'nvarchar' then '('+ (case when c.max_length < 0 then 'MAX' else convert(varchar,c.max_length) end )+')' else '' end)
	 + case c.is_nullable when 1 then ' Null' else ' Not Null' end

		FROM sys.columns c
	JOIN sys.types AS t ON c.user_type_id=t.user_type_id
	WHERE c.[object_id] = @o
		AND c.is_identity = @isIdentity;

	SELECT @c = STUFF(@c, 1, 1, '');

	return @c;

END
