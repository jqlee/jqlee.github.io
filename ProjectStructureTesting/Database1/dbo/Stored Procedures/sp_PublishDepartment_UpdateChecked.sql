-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PublishDepartment_UpdateChecked]
	-- Add the parameters for the stored procedure here
	@publishNumber int = 0
	,@departmentId varchar(20) = null
	,@semeString varchar(3) = null
	,@checked bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--如果有子項的跳過
	if (exists(select 0 from v_Department where ParentId = @departmentId))
	return;

	declare @oldSeme tinyint
    -- Insert statements for procedure here
	if (exists(SELECT 0 from PublishDepartment 
		where PublishNumber = @publishNumber and DepartmentId = @departmentId
	))
	begin
		if (@checked = 0) 
			delete from PublishDepartment where PublishNumber = @publishNumber and DepartmentId = @departmentId;
		else
		begin
			Update PublishDepartment set [Seme] = @semeString
				where PublishNumber = @publishNumber and DepartmentId = @departmentId and convert(varchar(3),[Seme]) <> @semeString
		end

	end
	else
	begin

		if (@checked = 1)  
			insert into PublishDepartment (PublishNumber, DepartmentId, [Seme]) 
			values (@publishNumber, @departmentId, convert(tinyint, @semeString))
	end

END
