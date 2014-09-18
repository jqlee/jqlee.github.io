-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Target_BuildFromCondition]
	-- Add the parameters for the stored procedure here
	@conditionNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    begin tran T1
		declare @surveyNumber int
		declare @targetMark int
		declare @keyword varchar(20)
		declare @roleCode varchar(6)
		declare @memberGrade int
		declare @groupYear int
		--declare @creator varchar(20)

		--select * from [Condition]
		/*
		select @surveyNumber = [Number], @targetMark = [TargetMark] 
			from [Survey] where [Number] = @surveyNumber

		select @keyword = [Keyword], @roleCode = [RoleCode], @memberGrade = [MemberGrade], @groupYear= [GroupYear]
			from [Condition] where [Number] = @conditionNumber
		*/
		select @surveyNumber = c.[SurveyNumber], @targetMark = c.[TargetMark], @keyword = c.[Keyword], @roleCode = c.[RoleCode] 
		,@groupYear = c.[GroupYear], @memberGrade = c.[MemberGrade]
		from [Survey] s inner join [Condition] c on c.SurveyNumber = s.Number and c.TargetMark = s.TargetMark
		where c.[Number] = @conditionNumber

		--delete from [dbo].[Target] where [ConditionNumber] = @conditionNumber;

--		INSERT INTO [dbo].[Target] ([ConditionNumber],[TargetMark],[DepartmentId],[MatchKey],[MatchName],[RoleCode])

		--產生target
--INSERT INTO [dbo].[Target] ([ConditionNumber],[TargetMark],[DepartmentId],[MatchKey],[MatchName], [RoleCode])

-- 展開條件

-- MatchKey = DepartmentId+RoleCode+MemberGrade+GroupId
		
		declare @temp Table(
			[SurveyNumber] int,[ConditionNumber] int,[DepartmentId] varchar(20), [GroupId] varchar(20), [MemberGrade] int
			, [MatchKey] varchar(50), [MatchName] nvarchar(100), [RoleCode] varchar(6)
		)

		if (@targetMark = 4) 
		begin
			INSERT INTO @temp ([SurveyNumber], [ConditionNumber],[DepartmentId], [GroupId], [MemberGrade], [MatchKey], [MatchName], [RoleCode])
			select 
			@surveyNumber as [SurveyNumber]
			, @conditionNumber as [ConditionNumber], d.[DepartmentId]
			, g.Id as [GroupId]
			, null as MemberGrade
			, d.[DepartmentId]+'::'+g.Id+':'+@roleCode as [MatchKey]
			, '('+Convert( nvarchar(6),g.GroupYear) + ') ' + g.Id+' '+g.Name as [MatchName]
			, @roleCode as [RoleCode]
			--,g.* 
			from fnDepartmentList(@keyword) d 
			inner join v_DepartmentGroup g on g.DepartmentId = d.DepartmentId
			where g.GroupYear = ISNULL(@groupYear, g.GroupYear)

		end
		else if (@targetMark = 3) 
		begin
			INSERT INTO @temp ([SurveyNumber], [ConditionNumber],[DepartmentId], [GroupId], [MemberGrade], [MatchKey], [MatchName], [RoleCode])
			select 
				@surveyNumber as [SurveyNumber]
				, @conditionNumber as [ConditionNumber], d.[DepartmentId]
				--, convert( varchar(20), gl.Value) as [MatchKey]
				, null as [GroupId]
				, gl.Value as [MemberGrade]
				, d.[DepartmentId]+':'+convert(varchar(4),gl.Value)+'::'+@roleCode as [MatchKey]
				, d.[DepartmentId] + ' ' + d.DepartmentName + ' ' + gl.Name as [MatchName]
				,@roleCode as [RoleCode]
			from fnDepartmentList(@keyword) d 
			inner join fnGetGradeList() gl on gl.[Value] = isNull(@memberGrade,gl.[Value])
		end


		--select * from @temp 
		--select distinct [SurveyNumber], [DepartmentId], [GroupId], [MemberGrade], [MatchKey], [MatchName], [RoleCode] from @temp 
		/*
		select * from [ConditionTarget]

		select ct.TargetNumber
		from [ConditionTarget] ct 
		inner join [Target] t on ct.TargetNumber = t.[Number] 
		where ct.[ConditionNumber] = @conditionNumber --ct.ConditionNumber = @conditionNumber --ct.[ConditionNumber] = 73
		group by ct.TargetNumber
		having count(ct.[ConditionNumber])  = 1

		select * from [Target] where Number = 9209
		*/

		--清理設定(只刪除差集)
		/*
		delete from [Target]
		from [ConditionTarget] ct 
		left outer join [Target] t on ct.TargetNumber = t.[Number] 
		where ct.[ConditionNumber] = @conditionNumber and ;
		*/
		delete from [Target] where Number in (
		select ct.TargetNumber
		from [ConditionTarget] ct 
		inner join [Target] t on ct.TargetNumber = t.[Number] 
		where ct.[ConditionNumber] = @conditionNumber --ct.ConditionNumber = @conditionNumber --ct.[ConditionNumber] = 73
		group by ct.TargetNumber
		having count(ct.[ConditionNumber])  = 1
		)

		/*
		delete from [Target]
		from [Target] t inner join [ConditionTarget] ct on ct.TargetNumber = t.[Number] 
		where ct.[ConditionNumber] = @conditionNumber;
		*/

		-- [Target] 必須以 SurveyNumber + MatchKey 做PK
		-- 用@temp 與 [Target] join，重疊者表示與舊有條件設定重複，無重疊者表示同一份問卷內未有該條件
		-- 先塞不重複項目到Target，再將Target與@temp join塞進ConditionTarget

		INSERT INTO [dbo].[Target] ([SurveyNumber], [DepartmentId], [GroupId], [MemberGrade], [MatchKey], [MatchName], [RoleCode])
		select distinct tt.[SurveyNumber], tt.[DepartmentId], tt.[GroupId], tt.[MemberGrade], tt.[MatchKey], tt.[MatchName], tt.[RoleCode] 
		from @temp tt 
		left outer join [Target] t on t.SurveyNumber = tt.[SurveyNumber] and t.MatchKey = tt.MatchKey
		where t.Number is null


		delete from [ConditionTarget] where [ConditionNumber] = @conditionNumber;
		Insert Into [ConditionTarget] ([TargetNumber],[ConditionNumber])
		select distinct t.[Number] as [TargetNumber],tt.[ConditionNumber]
		from @temp tt 
		inner join [Target] t on t.[SurveyNumber] = tt.[SUrveyNumber] and t.[MatchKey] = tt.[MatchKey]

		/*

		select * from [ConditionTarget]
		select @conditionNumber as [ConditionNumber]
			, @targetMark as [TargetMark]
			, d.DepartmentId --,d.DepartmentName
			, case when @targetMark = 3 then gl.Value when @targetMark = 4 then yl.Value else null end as [MatchKey] 
			, case when @targetMark = 3 then gl.Name when @targetMark = 4 then yl.Name else null end as [MatchName] 
			, @roleCode as [RoleCode]
		from dbo.fnGetTreeFromDepartment(@keyword) d
		left outer join fnGetGradeList() gl on gl.[Value] = isNull(@memberGrade,gl.[Value]) and @targetMark = 3
		left outer join fnGetYearList() yl on yl.[Value] = isNull(@groupYear,yl.[Value]) and yl.[DepartmentId] = d.DepartmentId and @targetMark = 4
		where d.ChildrenCount = 0 and (gl.[Value] is not null or yl.[Value] is not null)
		*/


	commit tran T1

	
END

