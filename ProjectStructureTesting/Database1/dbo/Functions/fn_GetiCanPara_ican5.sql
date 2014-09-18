-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetiCanPara_ican5]
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
	select * from ican5.dbo.udf_GetIcanPara(@schoolId,@para_code)
)
