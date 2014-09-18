-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountGroupMemberBySurveyId]
(	
	-- Add the parameters for the function here
	--@indexGuid uniqueidentifier
	@surveyId uniqueidentifier
	,@teacherRole varchar(6) = '2000'

)
RETURNS TABLE 
AS
RETURN 
(
	
select ps.Number as SurveyNumber, gm.GroupId,gmt.MemberId as GroupTeacherId, gm.RoleCode as GroupRole, count(gm.memberId) as MemberCount
from 
/*
RecordScoreIndex rsi
inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
inner join */
PublishSetting ps --on ps.Number = sc.PublishNumber
inner join PublishTarget pt on pt.PublishNumber = ps.Number
inner join PublishDepartment pd on pd.PublishNumber = ps.Number
inner join v_Group g on g.DepartmentId = pd.DepartmentId and g.Year = pt.GroupYear and g.Seme = pt.GroupSeme and g.Grade = pt.GroupGrade
inner join v_GroupMember gm on gm.GroupId = g.Id and gm.RoleCode = pt.GroupRole
inner join v_GroupMember gmt on gmt.GroupId = g.Id and gmt.RoleCode = @teacherRole
where --rsi.[Guid] = @indexGuid
ps.[Guid] = @surveyId
group by ps.Number,gm.GroupId,gmt.MemberId, gm.RoleCode


)
