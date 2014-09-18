-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description: 回傳學生應答的問卷清單
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyMatch_GetListForUser]
	-- Add the parameters for the stored procedure here
	@memberId varchar(20) = null
	,@year smallint = 0
	,@seme tinyint = 0 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (@year = 0) set @year = null;
	if (@seme = 0) set @seme = null;

    -- Insert statements for procedure here

	-- 因為是要產生連結的，必須提供publishGuid
--declare @memberId varchar(20) = '97650773'
select 
m.RecordNumber, m.RecordDone, m.RecordLastAccessTime
,ps.Number as SurveyNumber,ps.[Guid] as SurveyId ,ps.Name as PublishName, ps.TargetMark, ps.[Enabled] as PublishEnabled, ps.IsPublished
,ps.PeriodYear, ps.PeriodSeme, ps.Period, ps.OpenDate, ps.CloseDate
,m.PublishNumber, m.GroupId, m.GroupName,m.GroupTeacherId, m.GroupTeacherName
, p.Number as PaperNumber
, m.MemberId, m.MemberName
from v_MatchRecord m
inner join PublishSetting ps on ps.Number = m.PublishNumber
inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
--left outer join Record r on r.PublishNumber = m.PublishNumber and r.GroupId = m.GroupId and r.GroupTeacherId = m.GroupTeacherId and r.GroupRole = m.GroupRole
where m.MemberId = @memberId 
and ps.IsPublished = 1 and ps.[Enabled] = 1 
and ps.PeriodYear = isNull(@year,ps.PeriodYear) and ps.PeriodSeme = isNull(@seme,ps.PeriodSeme)
order by ps.Number,m.GroupId,m.GroupTeacherId, m.GroupRole

/*
select 
r.Number as RecordNumber, r.Done as RecordDone, r.LastAccessTime as RecordLastAccessTime
,ps.Number as SurveyNumber,ps.[Guid] as SurveyId ,ps.Name as PublishName, ps.TargetMark, ps.[Enabled] as PublishEnabled, ps.IsPublished
,ps.PeriodYear, ps.PeriodSeme, ps.Period, ps.OpenDate, ps.CloseDate
,t.PublishNumber, t.GroupId, t.GroupName,t.GroupTeacherId, t.GroupTeacherName
, p.Number as PaperNumber
, gm.MemberId, m.Name as MemberName
from v_GroupMember gm
inner join v_GroupMember gmt on gmt.GroupId = gm.GroupId and gmt.RoleCode = '2000'
inner join v_Ticket t on t.GroupId = gm.GroupId and t.GroupTeacherId = gmt.MemberId
inner join PublishSetting ps on ps.Number = t.PublishNumber
inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
inner join v_Member m on m.Id = gm.MemberId
left outer join Record r on r.PublishNumber = t.PublishNumber and r.GroupId = t.GroupId and r.GroupTeacherId = t.GroupTeacherId and r.MemberId = gm.MemberId
where ps.IsPublished = 1 and gm.MemberId = @memberId
 and ps.PeriodYear = @year and ps.PeriodSeme = @seme
order by ps.OpenDate desc
*/
	/*
	select ps.[Guid] as [SurveyId]
	,ps.Name as PublishName, ps.TargetMark, ps.[Enabled] as PublishEnabled, ps.IsPublished
	,ps.PeriodYear, ps.PeriodSeme, ps.Period, ps.OpenDate, ps.CloseDate
	,r.LastAccessTime
	,mt.Name as GroupTeacherName
	,p.[Guid] as PaperGuid
	,sm.* 
	from v_MatchRecord sm
	left outer join v_Member mt on mt.Id = sm.GroupTeacherId
	inner join PublishSetting ps on ps.Number = sm.PublishNumber -- sm.SurveyNumber
	inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	left outer join Record r on r.Number = sm.RecordNumber
	where ps.IsPublished = 1 and 1 = case when ps.TargetMark = 1 and mt.Id is null then 0 else 1 end
	and sm.MemberId = @memberId and ps.PeriodYear = @year and ps.PeriodSeme = @seme
	*/
END


/*
declare @memberId varchar(20) = '97650773'
exec sp_SurveyMatch_GetListForUser @memberId,100,1

select top 10 * from v_Ticket

declare @memberId varchar(20) = '97650773'
select 
r.Number as RecordNumber, r.Done as RecordDone, r.LastAccessTime
ps.Number as SurveyNumber,ps.[Guid] as SurveyId ,ps.Name as PublishName, ps.TargetMark, ps.[Enabled] as PublishEnabled, ps.IsPublished
,ps.PeriodYear, ps.PeriodSeme, ps.Period, ps.OpenDate, ps.CloseDate
,t.PublishNumber, t.GroupId, t.GroupName,t.GroupTeacherId, t.GroupTeacherName
, gm.MemberId, m.Name as MemberName
from v_GroupMember gm
inner join v_GroupMember gmt on gmt.GroupId = gm.GroupId and gmt.RoleCode = '2000'
inner join v_Ticket t on t.GroupId = gm.GroupId and t.GroupTeacherId = gmt.MemberId
inner join PublishSetting ps on ps.Number = t.PublishNumber
inner join v_Member m on m.Id = gm.MemberId
left outer join Record r on r.PublishNumber = t.PublishNumber and r.GroupId = t.GroupId and r.GroupTeacherId = t.GroupTeacherId and r.MemberId = gm.MemberId
where gm.MemberId = @memberId

select Convert(tinyint,1) as TargetMark,rt.GroupRoleName as [RoleName], rt.GroupTeacherId as TeacherId, rt.GroupteacherName as TeacherName
,rt.*, mr.MemberId, mr.MemberName,r.Done as RecordDone,r.LastAccessTime
from RecordTarget rt
inner join v_MatchRecord mr on mr.PublishNumber = rt.PublishNumber and mr.GroupId = rt.GroupId and mr.GroupTeacherId = rt.GroupTeacherId and mr.GroupRole = rt.GroupRole
left outer join Record r on r.Number = mr.RecordNumber
where mr.MemberId = '97650773'
*/