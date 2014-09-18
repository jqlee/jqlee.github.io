-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create FUNCTION [dbo].[fnDepartmentPermission_ican5]
(	
	-- Add the parameters for the function here
	@memberId varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select distinct coll_no
	from ican5.dbo.udf_GetPermCollsWithSAOOA(@memberId)
)
