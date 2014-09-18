-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION fn_GetQuestionKey
(
	@questionNumber int
	,@subsetNumber int
	,@groupingNumber int
)
RETURNS varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @output varchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @output = convert(varchar, @questionNumber)+'_'+convert(varchar, @subsetNumber)+'_'+convert(varchar, @groupingNumber) 

	-- Return the result of the function
	RETURN @output

END
