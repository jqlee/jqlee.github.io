-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TargetMatch_GetList]
	-- Add the parameters for the stored procedure here
	@surveyNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		declare @targetMark tinyint
   		SELECT @targetMark = TargetMark FROM Survey WHERE Number = @surveyNumber

		if (@targetMark =2 or @targetMark = 3)

		select @targetMark as TargetMark, t.Number as TargetNumber
		--, t.DepartmentId as [TargetKey], t.MemberGrade as [TargetFilter]
		, d.Id as [MatchKey], m.Grade as [MatchFilter], d.Name as MartchName
		,m.Id as MemberId, m.Name as MemberName
		 from TargetForDepartment t
		inner join v_Department d on d.Id = t.DepartmentId
		inner join v_Member m on m.DepartmentId = d.Id and m.Grade = isNull(t.MemberGrade,m.Grade) and m.[Enabled] = 1 and m.RoleCode = t.RoleCode
		where t.SurveyNumber = @surveyNumber
		--insert into @Table ([TargetMark],[MatchKey],[MatchName]) 
		--select @targetMark as TargetMark, Id as [MatchKey], Name as [MatchName] from v_Department
	else
		select @targetMark as TargetMark, t.Number as TargetNumber
		--, t.DepartmentId as [TargetKey], t.GroupYear as [TargetFilter]
		, g.Id as [MatchKey], g.GroupYear  as [MatchFilter], g.Name as MartchName
		,m.Id as MemberId, m.Name as MemberName
		 from TargetForDepartment t
		inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId and g.GroupYear = ISNULL(t.GroupYear,g.GroupYear)
		inner join v_GroupMember gm on gm.GroupId = g.Id and gm.[Enabled] = 1
		inner join v_Member m on m.Id = gm.MemberId and m.[Enabled] = 1 and m.RoleCode = t.RoleCode
		
		where t.SurveyNumber = @surveyNumber 
END
