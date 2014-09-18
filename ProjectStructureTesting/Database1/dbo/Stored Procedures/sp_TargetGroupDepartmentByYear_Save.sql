
CREATE PROCEDURE [dbo].[sp_TargetGroupDepartmentByYear_Save]
	@surveyNumber int
	,@groupYear int
	,@departmentId varchar(8)
	,@name nvarchar(50) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[TargetGroupDepartmentByYear] where [SurveyNumber] = @surveyNumber and [GroupYear] = @groupYear and [DepartmentId] = @departmentId ))
	begin
		 return; 
	end
	else
	begin
		
		Insert into [dbo].[TargetGroupDepartmentByYear] (
			[SurveyNumber], 
			[GroupYear], 
			[DepartmentId],
			[Name]
		) values (
			 @surveyNumber, 
			 @groupYear, 
			 @departmentId,
			 @name
		)

	end
END


