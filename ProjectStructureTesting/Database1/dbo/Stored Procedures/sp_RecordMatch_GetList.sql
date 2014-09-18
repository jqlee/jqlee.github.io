-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordMatch_GetList]
	-- Add the parameters for the stored procedure here
	@memberId varchar(20) = null
	,@showDays int = 7
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- rm.RecordNumber is null表示是新的，還沒開始的

	--select * from [v_TargetMatch] where MemberId = '99702207'
		

--declare @memberId varchar(20) = '96830034'
--declare @showDays int = 14;

select ROW_NUMBER() over ( order by t.SurveyNumber,t.[MatchKey]) as RowIndex 
, t.MatchKey, t.SurveyNumber
, s.Name + ': ' + t.MatchName as [SurveyName]
, s.StartDate, s.EndDate, s.[Guid] as [SurveyId]
, tm.DepartmentId, tm.GroupId, tm.MemberGrade, tm.RoleCode
, r.[Number] as RecordNumber, isNull(r.[Done],0) as [Done], r.LastAccessTime
, datediff(second, getdate(), s.StartDate) as [DateRemain], datediff(second, s.EndDate, getdate()) as [DateExpired]
from [Target] t
inner join v_TargetMatch tm on tm.MatchKey = t.MatchKey
inner join [Survey] s on s.Number = t.SurveyNumber

left outer join [Record] r on r.SurveyNumber = tm.SurveyNumber and r.[MatchKey] = tm.[MatchKey] and r.MemberId = tm.MemberId

where tm.MemberId = @memberId
-- and t.SurveyNumber = 1250 --for test
and s.[Enabled] = 1 and s.[Visible] = 1
--and s.[StateMark] = 3 --審核通過
and getdate() between dateadd(d, -1*@showDays, s.StartDate) and dateadd(d,  @showDays, s.EndDate)
order by isNull(r.[Done], 0), s.[EndDate] desc, s.Name
	
	/*


	select ROW_NUMBER() over ( order by st.SurveyNumber,st.[MatchKey]) as RowIndex 
	, st.MatchKey, st.SurveyNumber
	, st.SurveyName + ': ' + st.MatchName as [SurveyName]
	, st.StartDate, st.EndDate, st.[Guid] as [SurveyId]
	, tm.DepartmentId, tm.GroupId, tm.MemberGrade, tm.RoleCode
	, r.[Number] as RecordNumber, isNull(r.[Done],0) as [Done], r.LastAccessTime
	, datediff(second, getdate(), st.StartDate) as [DateRemain], datediff(second, st.EndDate, getdate()) as [DateExpired]
	from [v_TargetMatch] tm
	inner join [Target] t on t.MatchKey = tm.MatchKey
	inner join (
		--在這跳過範圍重疊的條件
		select distinct s.Name as SurveyName,s.StartDate, s.EndDate,s.[Guid],s.[Enabled],s.[Visible]
		, t.SurveyNumber, t.MatchKey,t.MatchName 
		from [Survey] s 
		inner join [Target] t on t.SurveyNumber = s.[Number]
	) st on st.SurveyNumber = tm.SurveyNumber and st.MatchKey = tm.MatchKey
	/*
	inner join (
		--在這跳過範圍重疊的條件
		select distinct s.*, t.MatchKey,t.MatchName 
		from [Survey] s 
		inner join [Condition] c on c.SurveyNumber = s.Number
		inner join [Target] t on t.ConditionNumber = c.[Number]
	) st on st.Number = tm.SurveyNumber and st.MatchKey = tm.MatchKey
	*/
	left outer join [Record] r on r.SurveyNumber = tm.SurveyNumber and r.[MatchKey] = tm.[MatchKey] and r.MemberId = tm.MemberId
	where tm.MemberId = @memberId
		and st.[Enabled] = 1 and st.[Visible] = 1
		--and s.[StateMark] = 3 --審核通過
		and getdate() between dateadd(d, -1*@showDays, st.StartDate) and dateadd(d,  @showDays, st.EndDate)
	order by isNull(r.[Done], 0), st.[EndDate] desc, st.SurveyName

	*/


	/*
	select ROW_NUMBER() over ( order by s.Number,t.[MatchKey]) as RowIndex 
	,t.MatchKey
	, s.Name + ': ' + t.MatchName as [SurveyName]
	, tm.DepartmentId, tm.GroupId, tm.MemberGrade, tm.RoleCode
	, r.[Number] as RecordNumber, isNull(r.[Done],0) as [Done], r.LastAccessTime
	, s.Number as SurveyNumber, s.StartDate, s.EndDate, s.[Guid] as [SurveyId]
	, datediff(second, getdate(), s.StartDate) as [DateRemain], datediff(second, s.EndDate, getdate()) as [DateExpired]
	from [v_TargetMatch] tm
	inner join [Target] t on ---t.Number = tm.TargetNumber
	inner join [Condition] c on c.Number = t.ConditionNumber


	inner join [Survey] s on s.Number = c.SurveyNumber
	left outer join [Record] r on r.[MatchKey] = t.[MatchKey] and r.MemberId = tm.MemberId
	where tm.MemberId = @memberId
		and s.[Enabled] = 1 and s.[Visible] = 1
		--and s.[StateMark] = 3 --審核通過
		and getdate() between dateadd(d, -1*@showDays, s.StartDate) and dateadd(d,  @showDays, s.EndDate)
	order by isNull(r.[Done], 0), s.[EndDate] desc, s.[Name]
	*/

	

	/*
	select ROW_NUMBER() over ( order by m.SurveyNumber,m.[MatchKey], m.[MatchFilter]) as RowIndex 
	,m.*
	, s.Name as SurveyName
	, r.Number as RecordNumber, isNull(r.Done, 0) as Done, r.LastAccessTime, s.StartDate, s.EndDate, s.[Guid] as [SurveyId]
	, datediff(second, getdate(), s.StartDate) as [DateRemain], datediff(second, s.EndDate, getdate()) as [DateExpired]
	 from dbo.fnGetMatch(@memberId) m
		inner join Survey s on s.Number = m.SurveyNumber
--		left outer join RecordMatch rm on rm.SurveyNumber = m.SurveyNumber and rm.[Key] = m.[Key] and rm.Filter = m.Filter
		left outer join Record r on  r.SurveyNumber = s.Number and r.MemberId = @memberId
		 and r.[MatchKey] = m.[MatchKey] and r.MatchFilter = m.[MatchFilter]
	--where rm.RecordNumber is null
	where 
		s.[Enabled] = 1 and s.[Visible] = 1
		--and s.[StateMark] = 3 --審核通過
		and getdate() between dateadd(d, -1*@showDays, s.StartDate) and dateadd(d,  @showDays, s.EndDate)
		
	order by isNull(r.[Done], 0), s.[EndDate] desc, s.[Name]
	*/
END
