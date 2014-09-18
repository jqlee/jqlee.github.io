-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SurveyMatch_GetList
	-- Add the parameters for the stored procedure here
	@surveyId uniqueidentifier
	,@memberId varchar(20) = null
	,@teacherRole varchar(6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select r.Number as RecordNumber, r.Done as RecordDone
	,ps.Number as SurveyNumber ,ps.[GuId] as SurveyId
	--, ps.Name as SurveyName, ps.OpenDate,ps.CloseDate,ps.QueryDate
	,pd.DepartmentId,pt.GroupYear, pt.GroupSeme,pt.GroupGrade
	, g.Id as GroupId,g.Name as GroupName
	, gmt.MemberId as TeacherId --, mt.Name as TeacherName
	, gm.MemberId as MemberId --, m.Name as MemberName
	, gm.RoleCode
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
	and gm.MemberId = isNull(@memberId,gm.MemberId)
	--and r.Number is not null

	
END
