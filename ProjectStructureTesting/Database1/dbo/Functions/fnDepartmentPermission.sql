-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnDepartmentPermission]
(	
	-- Add the parameters for the function here
	@memberId varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select coll_no as DepartmentId 
	from fnDepartmentPermission_ican5(@memberId)

	
)
