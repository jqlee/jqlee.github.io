
CREATE PROCEDURE [dbo].[sp_PublishDepartment_Save]
	@number int
	,@publishNumber int = null
	,@departmentId varchar(50) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[PublishDepartment] where [Number] = @number ))
	begin
		
		Update [dbo].[PublishDepartment] set 
			[PublishNumber] = isNull(@publishNumber, [PublishNumber]), 
			[DepartmentId] = isNull(@departmentId, [DepartmentId])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[PublishDepartment] (
			[Number], 
			[PublishNumber], 
			[DepartmentId]
		) values (
			 @number, 
			 @publishNumber, 
			 @departmentId
		)

	end
END

