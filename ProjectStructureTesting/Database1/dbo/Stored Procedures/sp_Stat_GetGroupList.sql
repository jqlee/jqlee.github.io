-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Stat_GetGroupList
	-- Add the parameters for the stored procedure here
	@publishGuid uniqueidentifier = null
	,@queryMember varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;

	--declare @publishGuid uniqueidentifier = '625c2a78-5d76-4f65-9c49-aaec033f40db'
	--declare @queryMember varchar(20) = 'atchao'
	select x.*, d.Name as DepartmentName, g.Name as GroupName, m.Name as TeacherName 
	--debug:
	--, g.PeriodYear,g.PeriodSeme, g.Grade
	from (
		select pt.Number as TargetNumber,pd.DepartmentId, gmt.GroupId, gmt.MemberId as TeacherId
		,count(gms.MemberId) as UserCount
		, Convert(decimal,0) as SubmitRate, Convert(decimal,0) as StandardDeviation, Convert(decimal,0)  as AverageScore
		from PublishSetting ps
		inner join PublishTarget pt on pt.PublishNumber = ps.Number
		inner join PublishDepartment pd on pd.PublishNumber = ps.Number
		inner join v_Group g on g.DepartmentId = pd.DepartmentId 
			and g.PeriodYear = pt.GroupYear and g.PeriodSeme = pt.GroupSeme and g.Grade = pt.GroupGrade
		inner join v_GroupMember gmt on gmt.GroupId = g.Id and gmt.RoleCode = '2000'
		left outer join v_GroupMember gms on gms.GroupId = g.Id 
			 and gms.RoleCode = pt.GroupRole
		where ps.[Guid] = @publishGuid
		group by pt.Number, pd.DepartmentId, gmt.GroupId, gmt.MemberId
	--	order by pd.DepartmentId, gmt.GroupId, gmt.MemberId
	) x 
	left outer join v_Department d on d.Id = x.DepartmentId
	left outer join v_Member m on m.Id = x.TeacherId
	left outer join v_Group g on g.Id = x.GroupId
	order by x.DepartmentId, x.GroupId, x.TeacherId
END
