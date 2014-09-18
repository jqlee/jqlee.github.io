-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyMatch_GetByRecordGuid]
	-- Add the parameters for the stored procedure here
	@recordGuid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select sm.* 
	, ps.Name as PublishName, ps.TargetMark, ps.[Enabled] as PublishEnabled, ps.IsPublished
	, ps.PeriodYear, ps.PeriodSeme, ps.Period, ps.OpenDate, ps.CloseDate
	,mt.Name as TeacherName
	,mr.RoleName as MemberRoleName
	,gr.RoleName as GroupRoleName
	, d.Name as DepartmentName
	from Record r 
	inner join v_SurveyMatch sm on sm.RecordNumber = r.Number
	inner join PublishSetting ps on ps.Number = sm.SurveyNumber
	left outer join v_Member mt on mt.Id = sm.TeacherId
	left outer join v_Role mr on mr.Category='Member' and mr.RoleCode = sm.MemberRole
	left outer join v_Role gr on gr.Category='Group' and gr.RoleCode = sm.GroupRole
	inner join v_Department d on d.Id = sm.DepartmentId

	where r.[Guid] = @recordGuid
	
END
