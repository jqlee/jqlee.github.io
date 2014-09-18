
CREATE PROCEDURE [dbo].[sp_TargetCondition_Save]
	@number int
	,@surveyNumber int = null
	,@targetMark tinyint = null
	,@name nvarchar(50) = null
	,@departmentId varchar(20) = null
	,@roleCode varchar(6) = null
	,@groupYear int = null
	,@memberGrade int = null
	,@creator varchar(20) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select 0 from [dbo].[TargetCondition] where [Number] = @number ))
	begin
		
		Update [dbo].[TargetCondition] set 
			[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			[TargetMark] = isNull(@targetMark, [TargetMark]), 
			[Name] = isNull(@name, [Name]), 
			[DepartmentId] = isNull(@departmentId, [DepartmentId]), 
			[RoleCode] = isNull(@roleCode, [RoleCode]), 
			[GroupYear] = isNull(@groupYear, [GroupYear]), 
			[MemberGrade] = isNull(@memberGrade, [MemberGrade])
		where [Number] = @number 

	end
	else
	begin

		if ( not exists(select 0 from [TargetCondition] 
			where [SurveyNumber] = @surveyNumber and [TargetMark] = @targetMark and [DepartmentId] = @departmentId
				and [RoleCode] = @roleCode and [GroupYear] = @groupYear and [MemberGrade] = @memberGrade
		))
		begin

		begin tran t1



		Insert into [dbo].[TargetCondition] (
			[SurveyNumber], 
			[TargetMark], 
			[Name], 
			[DepartmentId], 
			[RoleCode], 
			[GroupYear], 
			[MemberGrade], 
			[Creator]
		) values (
			 @surveyNumber, 
			 @targetMark, 
			 @name, 
			 @departmentId, 
			 @roleCode, 
			 @groupYear, 
			 @memberGrade, 
			 @creator
		)

		declare @conditionNumber int
		set @conditionNumber = scope_identity()

		--declare @temp Table([SurveyNumber] int,[DepartmentId] varchar(20),[DepartmentDepth] int,[MemberGrade] int,[RoleCode] varchar(6),[GroupYear] int,[TargetMark] int,[ConditionNumber] int)
		--insert into @temp ([SurveyNumber],[DepartmentId],[DepartmentDepth],[MemberGrade],[RoleCode],[GroupYear],[TargetMark],[ConditionNumber])
		--select @surveyNumber as [SurveyNumber], [DepartmentId] ,[Depth] as [DepartmentDepth]
		--,@memberGrade,@roleCode,@groupYear,@targetMark
		--,@conditionNumber as [ConditionNumber]
		--from dbo.fnGetTreeFromDepartment(@departmentId) 

		--以下這段須獨立出來提供重整條件使用
		delete from [dbo].[TargetForDepartment] where [ConditionNumber] = @conditionNumber;

		INSERT INTO [dbo].[TargetForDepartment] ([SurveyNumber],[DepartmentId],[DepartmentDepth],[MemberGrade],[RoleCode],[GroupYear],[TargetMark],[ConditionNumber])
		select @surveyNumber as [SurveyNumber], [DepartmentId] ,[Depth] as [DepartmentDepth]
		,@memberGrade,@roleCode,@groupYear,@targetMark
		,@conditionNumber as [ConditionNumber]
		from dbo.fnGetTreeFromDepartment(@departmentId) 
		where [ParentId] is not null and [ChildrenCount] = 0 -- 避免多層的狀況同一個條件每層符合一次，等於要重複作問卷
		
		--計算人數之後回存condition(?)

		commit tran t1
		end
	end
END

