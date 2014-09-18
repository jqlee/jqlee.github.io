-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyMatch_GetGroupList]
	-- Add the parameters for the stored procedure here
	@surveyId uniqueidentifier
	, @memberId varchar(20) = null
	, @teacherRole varchar(6)
	, @departmentId varchar(20) = null
	, @groupId varchar(20) = null
	, @groupYear smallint = 0
	, @groupSeme tinyint = 0
	, @groupGrade tinyint = 0
	, @groupRole varchar(6) = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (@groupYear = 0) set @groupYear = null
	if (@groupSeme = 0) set @groupSeme = null
	if (@groupGrade = 0) set @groupGrade = null

    -- Insert statements for procedure here
	select r.Number as RecordNumber, r.Done as RecordDone
	,ps.Number as SurveyNumber ,ps.[GuId] as SurveyId
	--, ps.Name as SurveyName, ps.OpenDate,ps.CloseDate,ps.QueryDate
	,pd.DepartmentId,pt.GroupYear, pt.GroupSeme,pt.GroupGrade
	, g.Id as GroupId,g.Name as GroupName
	, gmt.MemberId as TeacherId --, mt.Name as TeacherName
	, gm.MemberId as MemberId --, m.Name as MemberName
	, gm.RoleCode as GroupRole
	from PublishSetting ps
	inner join PublishTarget pt on pt.PublishNumber = ps.Number
	inner join PublishDepartment pd on pd.PublishNumber = ps.Number
	inner join v_Group g on g.DepartmentId = pd.DepartmentId and g.Year = pt.GroupYear and g.Seme = pt.GroupSeme and g.Grade = pt.GroupGrade
	inner join v_GroupMember gmt on gmt.GroupId = g.Id and gmt.RoleCode = @teacherRole
	--inner join v_Member mt on mt.Id = gmt.MemberId
	inner join v_GroupMember gm on gm.GroupId = g.Id and gm.RoleCode = pt.GroupRole
	--inner join v_Member m on m.Id = gm.MemberId
	left outer join Record r on r.PublishNumber = ps.Number and r.MemberId = gm.MemberId
		and r.GroupDepartmentId = pd.DepartmentId and r.GroupYear = pt.GroupYear and r.GroupSeme = pt.GroupSeme and r.GroupGrade = pt.GroupGrade and r.GroupRole = pt.GroupRole and r.GroupTeacherId = gmt.MemberId
	where ps.[Guid] = @surveyId
	and pd.DepartmentId = isNull(@departmentId,pd.DepartmentId)
	and g.Id = isNull(@groupId,g.Id)
	and pt.GroupYear = ISNULL(@groupYear, pt.GroupYear) and pt.GroupSeme = ISNULL(@groupSeme, pt.GroupSeme) and pt.GroupGrade = ISNULL(@groupGrade, pt.GroupGrade)
	and pt.GroupRole = ISNULL(@groupRole, pt.GroupRole)
	and gm.MemberId = isNull(@memberId,gm.MemberId)
	--and r.Number is not null

	
END
