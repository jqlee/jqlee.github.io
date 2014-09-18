-- for STD only
Create FUNCTION [dbo].[fn_GetiCanParaWithLangArea]
(	
	-- Add the parameters for the function here
	@schoolId varchar(6)
	,@para_code varchar(20)
	,@langArea char(2)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select * from fn_GetiCanParaWithLangArea_ican5std(@schoolId,@para_code, @langArea)
)
