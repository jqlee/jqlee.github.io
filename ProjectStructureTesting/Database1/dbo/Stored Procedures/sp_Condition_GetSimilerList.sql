﻿
CREATE PROCEDURE [dbo].[sp_Condition_GetSimilerList]
	@surveyNumber int = null
	,@targetMark tinyint = null
	,@departmentId varchar(50) = null
	,@roleCode varchar(6) = null
	,@groupYear int = null
	,@memberGrade int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT d.Name as [Name], r.RoleName, tc.*
	FROM [dbo].[Condition] tc 
	left outer join v_Department d on d.Id = tc.Keyword
	left outer join v_Role r on r.RoleCode = tc.RoleCode
	where [SurveyNumber] = @surveyNumber
	 and [TargetMark] = @targetMark
	 and Keyword = @departmentId
	 and tc.[RoleCode] = @roleCode
	 and isNull([GroupYear],-1) = isNull(@groupYear,-1)
	 and isNull([MemberGrade],-1) = isNull(@memberGrade,-1)
END

