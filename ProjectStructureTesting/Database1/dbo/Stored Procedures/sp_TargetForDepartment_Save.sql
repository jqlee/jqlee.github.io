
CREATE PROCEDURE [dbo].[sp_TargetForDepartment_Save]
	@number int
	,@surveyNumber int = null
	,@departmentId varchar(50) = null
	,@memberGrade int = null
	,@groupYear int = null
	,@creator varchar(20) = null
	,@targetMark tinyint = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[TargetForDepartment] where [Number] = @number ))
	begin
		
		Update [dbo].[TargetForDepartment] set 
			[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			[DepartmentId] = isNull(@departmentId, [DepartmentId]), 
			[MemberGrade] = isNull(@memberGrade, [MemberGrade]), 
			[GroupYear] = isNull(@groupYear, [GroupYear]), 
			[Creator] = isNull(@creator,[Creator]),
			[TargetMark] = isNull(@targetMark, [TargetMark])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[TargetForDepartment] (
			[SurveyNumber], 
			[DepartmentId], 
			[MemberGrade], 
			[GroupYear], 
			[Creator],
			[TargetMark]
		) values (
			 @surveyNumber, 
			 @departmentId, 
			 @memberGrade, 
			 @groupYear, 
			 @creator,
			 @targetMark
		)

	end
END

