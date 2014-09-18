-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Survey_GetUserCount]
	-- Add the parameters for the stored procedure here
	@surveyNumber int
AS
BEGIN
	SET NOCOUNT ON;
	select x.*,m.[Note] from (
	select 1 as [TargetMark], count(m.Id) as [UserCount] from TargetDepartment t
	--inner join v_Department d on d.Id = t.DepartmentId
	inner join v_Member m on m.DepartmentId = isNull(t.DepartmentId,m.DepartmentId) and m.[Level] = isNull(t.[Level],m.[Level])
	where t.[SurveyNumber] = @surveyNumber

	union all

	select 2 as [TargetMark], count(m.Id) as [UserCount] from TargetDepartmentGroup t
	inner join v_DepartmentGroup dg on dg.Id = t.GroupId
	inner join v_GroupMember gm on gm.GroupId = dg.Id
	inner join v_Member m on m.Id = gm.MemberId
	where t.[SurveyNumber] = @surveyNumber

	union all

	select 3 as [TargetMark], count(m.Id) as [UserCount] from TargetGroupDepartmentByYear t
	inner join v_DepartmentGroup dg on dg.DepartmentId = t.DepartmentId and dg.[Year] = t.[GroupYear]
	inner join v_GroupMember gm on gm.GroupId = dg.Id
	inner join v_Member m on m.Id = gm.MemberId
	where t.[SurveyNumber] = @surveyNumber

	union all

	select 4 as [TargetMark], count(m.Id) as [UserCount] from TargetGroupMember t
	inner join v_GroupMember gm on gm.GroupId = t.GroupId and gm.MemberId = t.MemberId
	inner join v_Member m on m.Id = gm.MemberId
	where t.[SurveyNumber] = @surveyNumber
	) x  inner join [SysMark] m on m.[Name] = 'TargetMark' and m.[Value] = x.[TargetMark]
END

