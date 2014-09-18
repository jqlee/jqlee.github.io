-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SurveyMatch_GetMemberList
	-- Add the parameters for the stored procedure here
	@surveyId uniqueidentifier
	, @memberId varchar(20) = null
	, @teacherRole varchar(6)
	, @departmentId varchar(20) = null
	, @memberGrade tinyint = 0
	, @memberRole varchar(6) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (@memberGrade = 0) set @memberGrade = null

    -- Insert statements for procedure here
	select r.Number as RecordNumber, r.Done as RecordDone
	,ps.Number as SurveyNumber ,ps.[GuId] as SurveyId
	--, ps.Name as SurveyName, ps.OpenDate,ps.CloseDate,ps.QueryDate
	,pd.DepartmentId
	,pt.MemberGrade, pt.MemberRole
	,d.Id as DepartmentId, d.Name as DepartmentName

	,m.Id as MemberId , m.RoleCode as MemberRole
	from PublishSetting ps
	inner join PublishTarget pt on pt.PublishNumber = ps.Number
	inner join PublishDepartment pd on pd.PublishNumber = ps.Number
	inner join v_Member m on m.DepartmentId = pd.DepartmentId
		and m.Grade = pt.MemberGrade and m.RoleCode = pt.MemberRole
	--inner join v_Member mt on mt.Id = gmt.MemberId
	--inner join v_Member m on m.Id = gm.MemberId
	inner join v_Department d on d.Id = pd.DepartmentId
	left outer join Record r on r.PublishNumber = ps.Number and r.MemberId = m.Id
		--and r.GroupDepartmentId = pd.DepartmentId and r.GroupYear = pt.GroupYear and r.GroupSeme = pt.GroupSeme and r.GroupGrade = pt.GroupGrade and r.GroupRole = pt.GroupRole and r.GroupTeacherId = gmt.MemberId
		and r.MemberDepartmentId = pd.DepartmentId and r.MemberGrade = pt.MemberGrade and r.MemberRole = pt.MemberRole
	where ps.[Guid] = @surveyId
	and pd.DepartmentId = isNull(@departmentId, pd.DepartmentId)
	and pt.MemberGrade = ISNULL(@memberGrade, pt.MemberGrade) 
	and pt.MemberRole = ISNULL(@memberRole, pt.MemberRole)
	and m.Id = isNull(@memberId,m.Id)
	
END
