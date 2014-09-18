-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetListForTextAnswer]
	-- Add the parameters for the stored procedure here
	--@indexGuid uniqueidentifier 
	@surveyId uniqueidentifier
	,@teacherRole varchar(6) = '2000'
	,@keyword nvarchar(max) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- 可能要把configNumber跟IndexNumber提出來先查好，方便在外層找target


select 
g.Name as GroupName
, gt.Name as GroupTeacherName
, g.DepartmentId as GroupDepartmentId
, d.Name as GroupDepartmentName
, g.Grade as GroupGrade
, g.Grp as GroupGrp
, null as MemberDepartmentName
, r.RoleName
, Convert(tinyint,1) as TargetMark
,x.* from (
	select mc.SurveyNumber, mc.GroupId, mc.GroupTeacherId
	, mc.GroupRole, null as MemberDepartmentId, null as MemberGrade, null as MemberRole
		, mc.MemberCount
		, count(x.RecordNumber) as RecordCount
	from (
		select r.GroupId, r.GroupTeacherId, r.GroupRole, r.Number as RecordNumber
		from PublishSetting ps
		inner join Record r on r.PublishNumber = ps.Number
		where ps.[Guid] = @surveyId and r.Done = 1
	) x
	
	right outer join dbo.fnCountGroupMemberBySurveyId(@surveyId, @teacherRole) mc 
		on mc.GroupId = x.GroupId and mc.GroupTeacherId = x.GroupTeacherId and mc.GroupRole = x.GroupRole
	group by mc.SurveyNumber,mc.GroupId, mc.GroupTeacherId, mc.GroupRole, mc.MemberCount

) x
left outer join v_Group g on g.Id = x.GroupId
left outer join v_Member gt on gt.Id = x.GroupTeacherId
left outer join v_Department d on d.Id = g.DepartmentId
left outer join v_Role as r on r.RoleCode = x.GroupRole and r.Category = 'Group'
where 1 = case when @keyword is null then 1
	when g.Id like '%' + @keyword +'%' then 1
	when gt.Id like '%' + @keyword +'%' then 1
	when gt.Name like '%' + @keyword +'%' then 1
	when g.Name like '%' + @keyword +'%' then 1
	when g.DepartmentId like '%' + @keyword +'%' then 1
	when d.Name like '%' + @keyword +'%' then 1
	else 0 end

union

select 
null as GroupName, null as GroupTeacherName
, null as GroupDepartmentId
, null as GroupDepartmentName
, null as GroupGrade
, null as GroupGrp
,d.Name as MemberDepartmentName
, r.RoleName
, Convert(tinyint,2) as TargetMark
,x.* 
from (
	-- 如果依照條件查，就只看整份 (人員滿意度)
	select mc.SurveyNumber, null as GroupId, null as GroupTeacherId, null as GroupRole,  mc.MemberDepartmentId, mc.MemberGrade, mc.MemberRole
		, mc.MemberCount
		, count(x.RecordNumber) as RecordCount
	from (
		select r.MemberDepartmentId, r.MemberGrade, r.MemberRole, r.Number as RecordNumber
		from PublishSetting ps
		inner join Record r on r.PublishNumber = ps.Number
		where ps.[Guid] = @surveyId and r.Done = 1
		and 1 = case when @keyword is null then 1
			when r.MemberDepartmentId like '%' + @keyword +'%' then 1
			else 0 end
	) x
	right outer join dbo.fnCountMemberBySurveyId(@surveyId) mc on mc.MemberDepartmentId = x.MemberDepartmentId and mc.MemberGrade = x.MemberGrade and mc.MemberRole = x.MemberRole
	group by mc.SurveyNumber,mc.MemberDepartmentId, mc.MemberGrade, mc.MemberRole, mc.MemberCount
) x
left outer join v_Department d on d.Id = x.MemberDepartmentId
left outer join v_Role as r on r.RoleCode = x.MemberRole and r.Category = 'Member'

END




/*
declare @surveyId uniqueidentifier = '86e318b8-4308-4d22-9dd7-6871f351fe95'
select * from dbo.fnCountGroupMemberBySurveyId(@surveyId, '2000')
select * from dbo.fnCountMemberBySurveyId(@surveyId)

exec sp_ScoreReport_GetListForTextAnswer '86e318b8-4308-4d22-9dd7-6871f351fe95'

select 
g.Name as GroupName
, gt.Name as GroupTeacherName
,g.DepartmentId as GroupDepartmentId
,d.Name as GroupDepartmentName
, g.Grade as GroupGrade
, null as MemberDepartmentName
, r.RoleName
,x.* from (
	select mc.GroupId, mc.GroupTeacherId
	, mc.GroupRole, null as MemberDepartmentId, null as MemberGrade, null as MemberRole
		, mc.MemberCount
		, count(x.RecordNumber) as RecordCount
	from (
	select r.GroupId, r.GroupTeacherId, r.GroupRole, r.Number as RecordNumber
	from PublishSetting ps
	inner join Record r on r.PublishNumber = ps.Number
	) x
	
	right outer join dbo.fnCountGroupMemberBySurveyId(@surveyId, '2000') mc 
		on mc.GroupId = x.GroupId and mc.GroupTeacherId = x.GroupTeacherId and mc.GroupRole = x.GroupRole
	group by mc.GroupId, mc.GroupTeacherId, mc.GroupRole, mc.MemberCount

) x
left outer join v_Group g on g.Id = x.GroupId
left outer join v_Member gt on gt.Id = x.GroupTeacherId
left outer join v_Department d on d.Id = g.DepartmentId
left outer join v_Role as r on r.RoleCode = x.GroupRole

--union

select 
null as GroupName, null as GroupTeacherName
, null as GroupDepartmentId
,null as GroupDepartmentName
, null as GroupGrade
,d.Name as MemberDepartmentName
, r.RoleName
,x.* 
from (
	-- 如果依照條件查，就只看整份 (人員滿意度)
	select null as GroupId, null as GroupTeacherId, null as GroupRole,  mc.MemberDepartmentId, mc.MemberGrade, mc.MemberRole
		, mc.MemberCount
		, count(x.RecordNumber) as RecordCount
	from (
		select r.MemberDepartmentId, r.MemberGrade, r.MemberRole, r.Number as RecordNumber
		from PublishSetting ps
		inner join Record r on r.PublishNumber = ps.Number
	) x
	right outer join dbo.fnCountMemberBySurveyId(@surveyId) mc on mc.MemberDepartmentId = x.MemberDepartmentId and mc.MemberGrade = x.MemberGrade and mc.MemberRole = x.MemberRole
	group by mc.MemberDepartmentId, mc.MemberGrade, mc.MemberRole, mc.MemberCount
) x
left outer join v_Department d on d.Id = x.MemberDepartmentId
left outer join v_Role as r on r.RoleCode = x.MemberRole


exec sp_ScoreReport_GetListForTextAnswer '86e318b8-4308-4d22-9dd7-6871f351fe95','2000', '1001CBNMD30459100'
*/