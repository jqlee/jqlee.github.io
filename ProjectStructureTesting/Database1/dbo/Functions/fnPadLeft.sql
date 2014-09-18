-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION fnPadLeft
(
	-- Add the parameters for the function here
	@value int = 0
	,@len int = 2
	, @char char(1) = '0'
)
RETURNS varchar(max)
AS
BEGIN
	-- Declare the return variable here
	declare @s varchar(max)

	set @s = REPLACE(STR(@value, @len), SPACE(1), @char)
	-- Return the result of the function
	RETURN  @s

END
