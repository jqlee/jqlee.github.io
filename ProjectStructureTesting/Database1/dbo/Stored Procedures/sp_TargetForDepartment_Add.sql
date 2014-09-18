
CREATE PROCEDURE [dbo].[sp_TargetForDepartment_Add]
	@surveyNumber int = null
	,@departmentId varchar(50) = null
	,@roleCode varchar(6) = null
	,@memberGrade int = null
	,@groupYear int = null
	,@creator varchar(20) = null
	,@targetMark tinyint = null
AS
BEGIN
	SET NOCOUNT ON;

	begin tran t1
		
		if (@departmentId='') set @departmentId = null;

		declare @origMark tinyint
		select @origMark = TargetMark from [Survey] where [Number] = @surveyNumber;
		
		if (@origMark <> @targetMark) 
		begin
			exec sp_TargetForDepartment_DeleteBySurvey @surveyNumber;
			update [Survey] set TargetMark = @targetMark where [Number] = @surveyNumber;
		end

		if (not exists( select 0 from [dbo].[TargetForDepartment] 
			where [SurveyNumber] = @surveyNumber and [DepartmentId] = @departmentId and [RoleCode] = @roleCode
			and (
				(@targetMark = 3 and ([MemberGrade] = @memberGrade or  [MemberGrade] is null)) 
				or (@targetMark = 4 and ([GroupYear] = @groupYear or [GroupYear] is null))
			)))
		begin
			if ((@targetMark = 3 and @memberGrade is null) or (@targetMark = 4 and @groupYear is null))
				delete from [dbo].[TargetForDepartment] 
					where [SurveyNumber] = @surveyNumber and [DepartmentId] = @departmentId 

			Insert into [dbo].[TargetForDepartment] (
				[SurveyNumber], 
				[DepartmentId],
				[RoleCode], 
				[MemberGrade], 
				[GroupYear], 
				[Creator],
				[TargetMark]
			) values (
				 @surveyNumber, 
				 @departmentId,
				 @roleCode,
				 @memberGrade, 
				 @groupYear, 
				 @creator,
				 @targetMark
			)
		end

	commit tran t1
END

