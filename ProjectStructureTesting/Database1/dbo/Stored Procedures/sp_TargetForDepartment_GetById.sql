
CREATE PROCEDURE [dbo].[sp_TargetForDepartment_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 t.*, d.Name--[Number], [SurveyNumber], [DepartmentId], [MemberGrade], [GroupYear], [TargetMark]
	FROM [dbo].[TargetForDepartment] t
	left outer join v_Department d on d.Id = t.DepartmentId
	where t.[Number] = @number
END
