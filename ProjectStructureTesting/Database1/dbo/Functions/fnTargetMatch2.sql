-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnTargetMatch2]
(	
	-- Add the parameters for the function here
	 @surveyNumber int
)
RETURNS @Table table ([Index] int identity(1,1), [SurveyNumber] int, [TargetMark] tinyint,[TargetNumber] int, [MatchKey] varchar(50), [MatchName] nvarchar(max), [MatchFilter] int , [MemberCount] int, [RecordCount] int)
begin
	-- Add the SELECT statement with parameter references here


	declare @targetMark tinyint

	SELECT @targetMark = TargetMark FROM Survey WHERE Number = @surveyNumber

	
	/*
	1,4: 檢查修課符合
	2,3: 檢查人員符合
	*/
	--select * from fnGetGradeList()



	if (@targetMark = 2 or @targetMark = 3)
	begin
		insert into @Table ([SurveyNumber],[TargetMark],[TargetNumber],[MatchKey],[MatchName],[MatchFilter],[MemberCount],[RecordCount]) 
		SELECT t.SurveyNumber, t.TargetMark, t.Number as TargetNumber, d.Id as MatchKey, d.Name as MatchName, isNull(m.Grade,0) as MatchFilter
			,count(distinct m.Id) as MemberCount
			,count(distinct r.Number) as RecordCount
		FROM TargetForDepartment t
			inner join v_Department d on d.Id = t.DepartmentId
			left outer join v_Member m on m.DepartmentId = t.DepartmentId and m.Grade = t.MemberGrade
			left outer join Record r on r.SurveyNumber = t.SurveyNumber and r.MatchKey = d.Id and r.MatchFilter = m.Grade and r.Done = 1
		where t.SurveyNumber = @surveyNumber and t.TargetMark = @targetMark
		group by t.SurveyNumber, t.TargetMark, t.Number , d.Id, d.Name, m.Grade
		--select @targetMark as TargetMark, Id as [MatchKey], Name as [MatchName] from v_Department
	end
	else
	begin --1, 4
		insert into @Table ([SurveyNumber],[TargetMark],[TargetNumber],[MatchKey],[MatchName],[MatchFilter],[MemberCount],[RecordCount]) 
		SELECT t.SurveyNumber, t.TargetMark, t.Number as TargetNumber, g.Id as MatchKey, g.Name as MatchName, g.GroupYear as MatchFilter
			,count(distinct gm.MemberId)  as MemberCount
			,count(distinct r.Number)  as RecordCount
		FROM TargetForDepartment t
			inner join v_DepartmentGroup g on g.DepartmentId = t.DepartmentId and g.GroupYear = t.GroupYear
			left outer join v_GroupMember gm on gm.GroupId = g.Id and gm.GroupRoleValue = 10 and gm.[Enabled] = 1
			left outer join Record r on r.SurveyNumber = t.SurveyNumber and r.MatchKey = g.Id and r.MatchFilter = g.GroupYear and r.Done = 1
		where t.SurveyNumber = @surveyNumber and t.TargetMark = @targetMark
		group by t.SurveyNumber, t.TargetMark, t.Number , g.Id, g.Name, g.GroupYear

/*
		select distinct @surveyNumber as [SurveyNumber], @targetMark as TargetMark, t.Number as TargetNumber, g.Id as [MatchKey]
		, g.Name+N'('+convert(nvarchar(20),g.GroupYear)+N')' as [MatchName], g.GroupYear as [MatchFilter]
		,gk.MemberCount, 0 as [RecordCount]
		from TargetForDepartment t 
		--inner join v_DepartmentGroup g on g.DepartmentId = isNull(t.DepartmentId, g.DepartmentId) and g.GroupYear = isNull(t.GroupYear,g.GroupYear)
		inner join ( --要確定[群組內有基本角色10的成員
			select g.Id,g.DepartmentId,g.GroupYear,count(gm.MemberId) as MemberCount
			from v_DepartmentGroup g inner join v_GroupMember gm on gm.GroupId = g.Id and gm.GroupRoleValue = 10 and gm.[Enabled] = 1
			group by g.Id,g.DepartmentId,g.GroupYear
		) gk on gk.DepartmentId = isNull(t.DepartmentId, gk.DepartmentId) and gk.GroupYear = isNull(t.GroupYear,gk.GroupYear)
		inner join v_DepartmentGroup g on g.Id = gk.Id
		
		where t.SurveyNumber = @surveyNumber and t.TargetMark = @targetMark
		--insert into @Table ([TargetMark],[MatchKey],[MatchName]) 
		--select @targetMark as TargetMark, Id as [MatchKey], Name as [MatchName] from v_DepartmentGroup
*/
	end
	return
end
