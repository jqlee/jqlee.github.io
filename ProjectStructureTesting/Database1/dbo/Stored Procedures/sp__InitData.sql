-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp__InitData]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- college
	Delete from [College];
	insert into [College] (Id, Name,[ShortName])
	select coll_no as [Id] , coll_name as [Name], coll_shortname as [ShortName]
	from  icanbeta3.ican5.dbo.college -- where coll_no in ('CBNCE','CBNBM','CBNPT','CBNAD','SPNCD','CBNMD');
	--select * from [College]

	Delete from [Course];
	insert into [Course] ([Id],[Name],[CollegeId],[Year])
	select course_no as [Id], cour_name_1000 as [Name], coll_no as [CollegeId], cour_year as [Year]
	from icanbeta3.ican5.dbo.course
	--select * from [Course]

	Delete from [Student];
	insert into [Student] ([Id],[Name],[CollegeId],[CollGrade],[CollGroup])
	select man_no as [Id], man_name as [Name], man_coll as [CollegeId], man_grade as [CollGrade], man_grp as [CollGroup]
	from icanbeta3.ican5.dbo.man
	--select * from [Student]

	--select top 10 * from icanbeta2.ican5.dbo.man
	Delete from [CourseStudent];
	insert into [CourseStudent] ([CourseId],[StudentId],[IsAudit])
	select course_no as [CourseId], man_no as [StudentId],  case manscore_type when '1010' then 1 else 0 end as [IsAudit]
	from icanbeta3.ican5.dbo.manscore where Left(manscore_type,2) = '10' and Len(course_no)>0
	--select * from [CourseStudent]

	---Targets

	delete from [TargetDepartment];
	insert into [TargetDepartment] ([SurveyNumber],[DepartmentId],[Level])
		select * from ( select top 3 (2) as [SurveyNumber]
			, [Id] as [DepartmentId]
			, ceiling(rand()*4) as [Level]  from [Department] order by newId() ) a
		union all
		select * from ( select top 2 (5) as [SurveyNumber]
			, [Id] as [DepartmentId]
			, null as [Level] from [Department] order by newId() ) c
		union all
		select * from ( select top 1 (3) as [SurveyNumber]
			, null as [DepartmentId]
			, ceiling(rand()*4) as [Level] from [Department] order by newId() ) b


	--select top 50 * from icanbeta2.ican5.dbo.manscore
	delete from [TargetGroupDepartmentByYear];
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (11,100,'CBNBM');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (11,100,'CBNAD');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (11,100,'CBNTR');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (12,100,'CBNCE');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (12,100,'CBNPT');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (13,100,'SPNCD');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (13,99,'CBNBM');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (14,99,'CBNAD');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (15,99,'CBNTR');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (15,99,'CBNCE');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (16,99,'CBNPT');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (16,98,'SPNCD');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (16,98,'CBNBM');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (17,98,'CBNAD');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (17,98,'CBNTR');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (17,99,'CBNCE');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (17,99,'CBNPT');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (18,100,'SPNCD');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (19,100,'CBNBM');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (19,100,'CBNAD');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (20,100,'CBNTR');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (20,100,'CBNCE');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (20,99,'CBNPT');
	insert into [TargetGroupDepartmentByYear] ([SurveyNumber],[GroupYear],[DepartmentId]) values (20,100,'SPNCD');

	--select * from TargetCourseCollegeByYear

	delete from [TargetDepartmentGroup];
	insert into [TargetDepartmentGroup] ([SurveyNumber],[GroupId])
		select * from (select top 7 (21) as [SurveyNumber], [Id] as [GroupId] from course order by newId()) a
		union all
		select * from (select top 2 (22) as [SurveyNumber], [Id] as [GroupId] from course order by newId()) b
		union all
		select * from (select top 4 (23) as [SurveyNumber], [Id] as [GroupId] from course order by newId()) c
		union all
		select * from (select top 5 (24) as [SurveyNumber], [Id] as [GroupId] from course order by newId()) d
		union all
		select * from (select top 1 (25) as [SurveyNumber], [Id] as [GroupId] from course order by newId()) e
	--select * from [TargetCourse]
	/*
	
	*/
	delete from [TargetGroupMember];
	
	insert into [TargetGroupMember] ( [SurveyNumber], [GroupId], [MemberId])
		select * from (select top 2 (26) as [SurveyNumber], [GroupId], [MemberId] from [GroupMember] order by newId()) a
		union all
		select * from (select top 3 (27) as [SurveyNumber], [GroupId], [MemberId] from [GroupMember] order by newId()) b
		union all
		select * from (select top 4 (28) as [SurveyNumber], [GroupId], [MemberId] from [GroupMember] order by newId()) c
		union all
		select * from (select top 1 (29) as [SurveyNumber], [GroupId], [MemberId] from [GroupMember] order by newId()) d
		union all
		select * from (select top 5 (30) as [SurveyNumber], [GroupId], [MemberId] from [GroupMember] order by newId()) e

	
	--select * from [TargetCourseUser]

END

