-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetListByCondition]
	-- Add the parameters for the stored procedure here
	@indexGuid uniqueidentifier 
	,@teacherRole varchar(6) = '2000'
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
,g.DepartmentId as GroupDepartmentId
,d.Name as GroupDepartmentName
, g.Grade as GroupGrade
, null as MemberDepartmentName
, r.RoleName
,x.* from (
	select mc.GroupId, mc.GroupTeacherId
	, mc.GroupRole, null as MemberDepartmentId, null as MemberGrade, null as MemberRole
	--, GroupDepartmentId, GroupYear, GroupSeme, GroupGrade, GroupRole, MemberDepartmentId, MemberGrade, MemberRole
		,x.ConfigNumber,x.IndexNumber
		, mc.MemberCount
		, count(x.RecordNumber) as RecordCount,AVG(x.TotalScore) as AvgScore , STDEV(x.TotalScore) as StdevScore , STDEVP(x.TotalScore) as StdevpScore
	from (
		select  r.GroupId, r.GroupTeacherId, r.GroupRole
			--, r.GroupDepartmentId, r.GroupYear, r.GroupSeme, r.GroupGrade, r.GroupRole, r.MemberDepartmentId, r.MemberGrade, r.MemberRole
			,rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, sum((rs.RawScore*rs.QuestionScoreSetting/100)/rs.QuestionItemCount) as TotalScore
		from RecordScoreIndex rsi
		inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
		inner join Record r on r.Number = rs.RecordNumber
		where rsi.[Guid] = @indexGuid
		group by r.GroupId, r.GroupTeacherId, r.GroupRole
		-- r.GroupDepartmentId, r.GroupYear, r.GroupSeme, r.GroupGrade, r.GroupRole, r.MemberDepartmentId, r.MemberGrade, r.MemberRole
			, rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber
	) x
	right outer join dbo.fnCountGroupMember(@indexGuid, '2000') mc 
	on mc.GroupId = x.GroupId and mc.GroupTeacherId = x.GroupTeacherId and mc.GroupRole = x.GroupRole
	group by mc.GroupId, mc.GroupTeacherId, mc.GroupRole, mc.MemberCount
	--GroupDepartmentId, GroupYear, GroupSeme, GroupGrade, GroupRole, MemberDepartmentId, MemberGrade, MemberRole
	,x.ConfigNumber,x.IndexNumber
) x
left outer join v_Group g on g.Id = x.GroupId
left outer join v_Member gt on gt.Id = x.GroupTeacherId
left outer join v_Department d on d.Id = g.DepartmentId
left outer join v_Role as r on r.RoleCode = x.GroupRole
	union 

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
	--, GroupDepartmentId, GroupYear, GroupSeme, GroupGrade, GroupRole, MemberDepartmentId, MemberGrade, MemberRole
		,x.ConfigNumber,x.IndexNumber
		, mc.MemberCount
		, count(x.RecordNumber) as RecordCount,AVG(x.TotalScore) as AvgScore , STDEV(x.TotalScore) as StdevScore , STDEVP(x.TotalScore) as StdevpScore
	from (
		select  r.MemberDepartmentId, r.MemberGrade, r.MemberRole
			--, r.GroupDepartmentId, r.GroupYear, r.GroupSeme, r.GroupGrade, r.GroupRole, r.MemberDepartmentId, r.MemberGrade, r.MemberRole
			,rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber, sum((rs.RawScore*rs.QuestionScoreSetting/100)/rs.QuestionItemCount) as TotalScore
		from RecordScoreIndex rsi
		inner join RecordQuestionScore rs on rs.IndexNumber = rsi.Number
		inner join Record r on r.Number = rs.RecordNumber
		where rsi.[Guid] = @indexGuid
		group by r.MemberDepartmentId, r.MemberGrade, r.MemberRole
		-- r.GroupDepartmentId, r.GroupYear, r.GroupSeme, r.GroupGrade, r.GroupRole, r.MemberDepartmentId, r.MemberGrade, r.MemberRole
			, rsi.ConfigNumber, rs.IndexNumber, rs.RecordNumber
	) x
	right outer join dbo.fnCountMember(@indexGuid) mc on mc.MemberDepartmentId = x.MemberDepartmentId and mc.MemberGrade = x.MemberGrade and mc.MemberRole = x.MemberRole
	group by mc.MemberDepartmentId, mc.MemberGrade, mc.MemberRole, mc.MemberCount
	--GroupDepartmentId, GroupYear, GroupSeme, GroupGrade, GroupRole, MemberDepartmentId, MemberGrade, MemberRole
	,x.ConfigNumber,x.IndexNumber
) x
left outer join v_Department d on d.Id = x.MemberDepartmentId
left outer join v_Role as r on r.RoleCode = x.MemberRole

END


/*

declare @indexGuid uniqueidentifier = '19062ea8-9fba-4fae-8376-f3065627f83e'
	,@teacherRole varchar(6) = '2000'

exec sp_ScoreReport_GetListByCondition @indexGuid, @teacherRole
*/