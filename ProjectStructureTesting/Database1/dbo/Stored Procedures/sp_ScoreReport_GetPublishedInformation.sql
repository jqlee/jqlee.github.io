-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	這跟sp_ScoreReport_GetInformation 唯一的差異是，這一支的 RecordCount 是根據開放的成績紀錄算出來的
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetPublishedInformation]
	-- Add the parameters for the stored procedure here
	@publishNumber int
	--,@departmentId varchar(20) = null
	,@groupId varchar(20) = null
	,@groupRole varchar(6) = null
	,@teacherId varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- 以下只有課程問卷(人員問卷待補)

	-- 查出開放的 indexGuid，用index取回有紀錄的答案



	select x.* 
	, g.Name as GroupName
	, mt.Name as GroupTeacherName
	, r.RoleName
	, z.RecordCount -- 到了統計不再考慮未完成的資料
	, y.MemberCount 
	from (
		select @publishNumber as SurveyNumber
		, ps.Name as SurveyName
		, @groupId as GroupId, @groupRole as [GroupRole]
		, @teacherId as [TeacherId]
		from PublishSetting ps
		where ps.Number = @publishNumber
	) x
	inner join v_Group g on g.Id = x.GroupId
	inner join v_Role r on r.RoleCode = x.GroupRole and r.Category = 'Group'
	inner join v_Member mt on mt.Id = x.TeacherId
	inner join (
		SELECT SurveyNumber
		, COUNT(MemberId) AS MemberCount
		FROM dbo.v_SurveyMatch 
		WHERE SurveyNumber = @publishNumber
		 and [GroupId] = isNull(@groupId, [GroupId])
		 and [GroupRole] = isNull(@groupRole, [GroupRole])
		 and [TeacherId] = isNull(@teacherId, [TeacherId])
		GROUP BY SurveyNumber
	) Y ON Y.SurveyNumber = x.SurveyNumber
	inner join (
		select sc.PublishNumber, count(distinct rqs.RecordNumber) as RecordCount
		from RecordScoreIndex rsi 
		inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
		inner join PublishSetting ps on ps.Number = sc.PublishNumber
		inner join RecordQuestionScore rqs on rqs.IndexNumber = rsi.Number
		inner join Record r on r.Number = rqs.RecordNumber and r.Done = 1
		where ps.Number = @publishNumber and rsi.IsPublished = 1 
			and r.[GroupId] = isNull(@groupId, r.[GroupId])
			and r.[GroupRole] = isNull(@groupRole, r.[GroupRole])
			and r.[GroupTeacherId] = isNull(@teacherId, r.[GroupTeacherId])
		group by sc.PublishNumber
	) Z ON z.PublishNumber = x.SurveyNumber


END

/*
declare @publishNumber int = 106
	,@groupId varchar(20) = '982CMNCT20D57900'
	,@groupRole varchar(6) = '1000'
	,@teacherId varchar(20) = 'T8900167'

--exec sp_ScoreReport_GetInformation @publishNumber,@groupId,@groupRole ,@teacherId

select sc.PublishNumber, count(distinct rqs.RecordNumber) as RecordCount
from RecordScoreIndex rsi 
inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
inner join PublishSetting ps on ps.Number = sc.PublishNumber
inner join RecordQuestionScore rqs on rqs.IndexNumber = rsi.Number
inner join Record r on r.Number = rqs.RecordNumber and r.Done = 1
where ps.Number = @publishNumber and rsi.IsPublished = 1 
	and r.[GroupId] = isNull(@groupId, r.[GroupId])
	and r.[GroupRole] = isNull(@groupRole, r.[GroupRole])
	and r.[GroupTeacherId] = isNull(@teacherId, r.[GroupTeacherId])
group by sc.PublishNumber

select * from v_SurveyMatch where SurveyNumber = 106
 and [GroupId] = '982CMNCT20D57900'
		 and [GroupRole] = '1000'
		 and [TeacherId] = 'T8900167'
*/
--select max(Number) from PublishSetting

/*

declare @publishNumber int = 106
	,@departmentId varchar(20) = null
	,@groupId varchar(20) = '982CMNCT20D57900'
	,@groupRole varchar(6) = '1000'
	,@teacherId varchar(20) = 'T8900167'

	select x.* 
	, g.Name as GroupName
	, mt.Name as GroupTeacherName
	, r.RoleName
	, y.CompleteCount as RecordCount -- 到了統計不再考慮未完成的資料
	, y.MemberCount ,r.*
	from (
		select @publishNumber as SurveyNumber
		, ps.Name as SurveyName
		, @groupId as GroupId, @groupRole as [GroupRole]
		, @teacherId as [TeacherId]
		from PublishSetting ps
		where ps.Number = @publishNumber
	) x
	inner join v_Group g on g.Id = x.GroupId
	inner join v_Role r on r.RoleCode = x.GroupRole
	inner join v_Member mt on mt.Id = x.TeacherId
	inner join (
		SELECT SurveyNumber
		, SUM(CASE WHEN RecordNumber IS NOT NULL THEN 1 ELSE 0 END) AS RecordCount
		, SUM(CASE WHEN RecordDone = 1 THEN 1 ELSE 0 END) AS CompleteCount
		, COUNT(MemberId) AS MemberCount
		FROM dbo.v_SurveyMatch 
		WHERE SurveyNumber = @publishNumber
		 and [GroupId] = isNull(@groupId, [GroupId])
		 and [GroupRole] = isNull(@groupRole, [GroupRole])
		 and [TeacherId] = isNull(@teacherId, [TeacherId])
		GROUP BY SurveyNumber
	) Y ON Y.SurveyNumber = x.SurveyNumber

*/