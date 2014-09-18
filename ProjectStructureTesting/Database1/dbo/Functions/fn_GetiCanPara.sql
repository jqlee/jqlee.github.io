CREATE FUNCTION [dbo].[fn_GetiCanPara]
(	
	-- Add the parameters for the function here
	@schoolId varchar(6)
	,@para_code varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select * from fn_GetiCanPara_ican5(@schoolId,@para_code)
)
