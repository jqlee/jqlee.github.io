-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetRandom]
(
	-- Add the parameters for the function here
	@NEWID as uniqueidentifier
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here

	-- Return the result of the function
	RETURN ABS(CONVERT(BIGINT,CONVERT(BINARY(8), @NEWID))) / 10000000000000000000

END
