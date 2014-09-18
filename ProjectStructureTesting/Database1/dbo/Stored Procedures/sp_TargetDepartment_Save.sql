
CREATE PROCEDURE [dbo].[sp_TargetDepartment_Save]
	@number int
	,@surveyNumber int = null
	,@departmentId varchar(20) = null
	,@level varchar(2) = null
	,@name nvarchar(50) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[TargetDepartment] where [Number] = @number ))
	begin
		
		Update [dbo].[TargetDepartment] set 
			[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			[DepartmentId] = isNull(@departmentId, [DepartmentId]), 
			[Level] = isNull(@level, [Level]),
			[Name] = isNull(@name, [Name])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[TargetDepartment] (
			[Number], 
			[SurveyNumber], 
			[DepartmentId], 
			[Level],
			[Name]
		) values (
			 @number, 
			 @surveyNumber, 
			 @departmentId, 
			 @level,
			 @name
		)

	end
END


