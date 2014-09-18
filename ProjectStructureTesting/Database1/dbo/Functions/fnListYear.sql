-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnListYear]
(	
	-- Add the parameters for the function here
	@schoolId varchar(6) 
)
RETURNS @t TABLE ([Value] int, [Name] nvarchar(20))
begin

	declare @startYear int = 2007, @maxYear int, @endYear int, @point int;

	set @endYear = year(getdate())+1;

	-- 查 v_DepartmentGroup 內的最大年份
	-- sce: cour_year varchar(3), cour_seme tinyint
	-- std: cour_year varchar(4), cour_seme tinyint
	-- 依照學校區分
	select @maxYear = max([Year]) from v_DepartmentGroup g 
	inner join v_Department d on d.Id = g.DepartmentId 
	where d.SchoolId = @schoolId

	if (@maxYear<1911) 
	begin
		set @startYear = @startYear - 1911;

	end

	set @point = @startYear;
	while (@point <= @maxYear)
	begin
		insert into @t ([Value],[name]) values (@point , convert(nvarchar(10),@point))
		set @point = @point + 1
	end

	return

end
