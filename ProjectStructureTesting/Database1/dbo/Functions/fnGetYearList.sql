-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetYearList]
(	
	-- Add the parameters for the function here
	--@departmentId varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	/*
	SELECT year(getdate()) as [Value]
	union 
	SELECT year(getdate())+1

	*/
	select distinct DepartmentId, GroupYear as [Value], DepartmentId +'['+ convert(nvarchar(20), GroupYear)+']' as [Name] from v_DepartmentGroup --where DepartmentId = @departmentId
)
