-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnDepartmentWithChildren
(	
	-- Add the parameters for the function here
	@departmentId varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select * 
	from v_Department 
	where id = @departmentId or parentid = @departmentId

)
