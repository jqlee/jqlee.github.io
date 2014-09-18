-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION dbo.fnGetRandomNumberString
(
	-- Add the parameters for the function here
	@newid uniqueidentifier,
	@len int = 1
)
RETURNS varchar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @n int
	declare @min int = Power(10,@len-1), @max int = Power(10,@len)-1
	select @n = @min+ convert(varchar,convert(bigint,dbo.fnGetRandom(@newid)* (@max-@min)))

	-- Return the result of the function
	RETURN convert(varchar(max), @n)

END
