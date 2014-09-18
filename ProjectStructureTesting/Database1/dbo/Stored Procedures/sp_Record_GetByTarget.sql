-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Record_GetByTarget]
	-- Add the parameters for the stored procedure here
	@targetNumber int =0 
	,@matchKey varchar(20) = null
	,@matchFilter int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	select x.*,r.Number as RecordNumber, r.Done, r.LastAccessTime, r.LastAccessPage from (
	select t.SurveyNumber,t.Number as TargetNumber,t.TargetMark, t.DepartmentId as MatchKey,gl.Value as MatchFilter, m.Id as MemberId, m.Name as MemberName
	from TargetForDepartment t 
	inner join fnGetGradeList() gl on gl.Value = isNull(t.MemberGrade,gl.Value)
	inner join v_Member m on m.DepartmentId = isNull(t.DepartmentId,m.DepartmentId) and m.Grade = gl.Value
	where t.TargetMark = 3 and m.[Enabled] = 1 and m.BasicRoleValue = 10 and t.Number = @targetNumber
	union
	select t.SurveyNumber,t.Number as TargetNumber,t.TargetMark,g.Id as MatchKey, g.GroupYear as MatchFilter, m.Id as MemberId, m.Name as MemberName
	from TargetForDepartment t 
	inner join v_DepartmentGroup g on  g.DepartmentId = isNull(t.DepartmentId,g.DepartmentId) and g.GroupYear = isNull(t.GroupYear, g.GroupYear)
	inner join v_GroupMember gm on gm.GroupId = g.Id 
	inner join v_Member m on m.Id = gm.MemberId
	--left outer join Record r on r.MemberId = m.Id and r.TargetNumber = t.Number and r.MatchKey = g.Id and r.MatchFilter = g.GroupYear
	where t.TargetMark = 4 and gm.[Enabled] = 1 and gm.GroupRoleValue = 10 and t.Number = @targetNumber
	) x
	left outer join Record r on r.SurveyNumber = x.SurveyNumber and r.MemberId = x.MemberId and r.MatchKey = x.MatchKey and r.MatchFilter = x.MatchFilter
	where x.MatchKey = @matchKey and x.MatchFilter = @matchFilter

END
