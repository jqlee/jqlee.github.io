
CREATE PROCEDURE [dbo].[sp_TargetDepartment_GetList]
	@surveyNumber int = null
	,@departmentId varchar(20) = null
	,@level varchar(2) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Number], [SurveyNumber], [DepartmentId], [Level], [Name]
	FROM [dbo].[TargetDepartment]
	where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
	 and [DepartmentId] = isNull(@departmentId,[DepartmentId])
	 and [Level] = isNull(@level,[Level])
END

