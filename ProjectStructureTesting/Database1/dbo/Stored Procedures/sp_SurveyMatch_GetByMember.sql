-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyMatch_GetByMember]
	-- Add the parameters for the stored procedure here
	@publishGuid uniqueidentifier
	, @memberId varchar(20) = null
	, @groupId varchar(20) = null
	, @groupTeacherId varchar(20) = null

AS
BEGIN
	SET NOCOUNT ON;

	select 
	r.Number as RecordNumber, r.Done as RecordDone, r.LastAccessTime
	,ps.Number as SurveyNumber,ps.[Guid] as SurveyId ,ps.Name as PublishName, ps.TargetMark, ps.[Enabled] as PublishEnabled, ps.IsPublished
	,ps.PeriodYear, ps.PeriodSeme, ps.Period, ps.OpenDate, ps.CloseDate
	,t.PublishNumber, t.GroupId, t.GroupName,t.GroupTeacherId, t.GroupTeacherName
	,t.GroupRole
	, p.Number as PaperNumber
	, gm.MemberId, m.Name as MemberName
	from v_GroupMember gm
	inner join v_GroupMember gmt on gmt.GroupId = gm.GroupId and gmt.RoleCode = '2000'
	inner join v_Ticket t on t.GroupId = gm.GroupId and t.GroupTeacherId = gmt.MemberId
	inner join PublishSetting ps on ps.Number = t.PublishNumber
	inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	inner join v_Member m on m.Id = gm.MemberId
	left outer join Record r on r.PublishNumber = t.PublishNumber and r.GroupId = t.GroupId and r.GroupTeacherId = t.GroupTeacherId and r.MemberId = gm.MemberId
	where ps.IsPublished = 1 and ps.[Guid] = @publishGuid and gm.MemberId = @memberId
	and t.GroupId = @groupId and t.GroupTeacherId = @groupTeacherId

END
