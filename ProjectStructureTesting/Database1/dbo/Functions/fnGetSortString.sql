-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION fnGetSortString
(
	-- Add the parameters for the function here
	@section int = 0
	,@questionSort int = 0
	,@subsetSort int = 0
	,@groupingSort int = 0
	
)
RETURNS varchar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @s varchar(max)

	-- Add the T-SQL statements to compute the return value here
	SELECT @s= dbo.fnPadLeft(isNull(@section,0), 2, '0') 
	+ dbo.fnPadLeft(isNull(@questionSort,0), 3, '0') 
	+ dbo.fnPadLeft(isNull(@subsetSort,0), 2, '0') 
	+ dbo.fnPadLeft(isNull(@groupingSort,0), 2, '0') 

	-- Return the result of the function
	RETURN @s;

END
