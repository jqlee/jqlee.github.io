-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyMatch_GetUserList]
	-- Add the parameters for the stored procedure here
	@surveyId uniqueidentifier
	,@keyword nvarchar(max) = null
	,@recordCount int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF OBJECT_ID('tempdb..#tempMatches') IS NOT NULL DROP TABLE #tempMatches

    -- Insert statements for procedure here
	SELECT sm.* 
	, ps.Name as PublishName, ps.TargetMark, ps.[Enabled] as PublishEnabled, ps.IsPublished
	, ps.PeriodYear, ps.PeriodSeme, ps.Period, ps.OpenDate, ps.CloseDate
	, m.Name as MemberName
	,mt.Name as TeacherName
	,mr.RoleName as MemberRoleName
	,gr.RoleName as GroupRoleName
	, d.Name as DepartmentName
	,r.LastAccessTime
	into #tempMatches
	from v_SurveyMatch sm
	inner join PublishSetting ps on ps.Number = sm.SurveyNumber
	left outer join v_Role mr on mr.Category='Member' and mr.RoleCode = MemberRole
	left outer join v_Role gr on gr.Category='Group' and gr.RoleCode = GroupRole
	inner join v_Member m on m.Id = sm.MemberId
	left outer join v_Member mt on mt.Id = sm.TeacherId
	left outer join Record r on r.Number = sm.RecordNumber
	inner join v_Department d on d.Id = sm.DepartmentId
	where sm.SurveyId = @surveyId
	and 1 = case when ps.TargetMark = 1 and mt.Id is null then 0 else 1 end
	and 1 = case
		when @keyword is null then 1 
		when @keyword is not null and (sm.MemberId like '%'+@keyword+'%' or m.Name like '%'+@keyword+'%') then 1 
		when @keyword is not null and ps.TargetMark = 2 and (sm.DepartmentId like '%'+@keyword+'%' or d.Name like '%'+@keyword+'%') then 1 
		when @keyword is not null and ps.TargetMark = 1 and (sm.GroupId like '%'+@keyword+'%' or sm.GroupName like '%'+@keyword+'%' or sm.TeacherId like '%'+@keyword+'%' or mt.Name like '%'+@keyword+'%') then 1 
		else 0 end

	select @recordCount = count(*) from #tempMatches
	select * from #tempMatches order by MemberId

END
