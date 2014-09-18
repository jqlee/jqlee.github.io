-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_GroupYear_GetList
	-- Add the parameters for the stored procedure here
	@departmentId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select GroupYear,count(*) as GroupCount 
	from v_DepartmentGroup 
	where DepartmentId = isNull(@departmentId, DepartmentId)
	group by GroupYear 
	order by GroupYear

END
