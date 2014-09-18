
CREATE PROCEDURE [dbo].[sp_Record_Save]
	@number int
	,@publishNumber int = null
	,@surveyNumber int = null
	,@guid uniqueidentifier = null
	,@departmentId varchar(20) = null
	--,@targetNumber int = null
	,@targetMark tinyint = null
	,@memberId varchar(50) = null
	,@memberName nvarchar(50) = null
	,@memberRole varchar(6) = null
	,@memberGrade tinyint = null
	,@done bit = null
	,@created datetime = null
	,@lastAccessPage tinyint = null
	,@lastAccessTime datetime = null
	,@courseId varchar(20) = null
	,@courseTeacherId varchar(20) = null
	,@courseTeacherName nvarchar(50) = null
	,@courseYear smallint = null
	,@courseSeme tinyint = null
	,@courseGrade tinyint = null
	,@courseRole varchar(6) = null
	,@overwriteIfExists bit = 1


AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Record] where [Number] = @number ))
	begin
		--紀錄主檔只更新狀態，內容欄位寫入後不再變動
		Update [dbo].[Record] set 
			--[PublishNumber] = isNull(@publishNumber, [PublishNumber]), 
			--[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			--[Guid] = isNull(@guid, [Guid]), 
			--[DepartmentId] = isNull(@departmentId, [DepartmentId]), 
			--[TargetNumber] = isNull(@targetNumber, [TargetNumber]), 
			--[TargetMark] = isNull(@targetMark, [TargetMark]), 
			--[MemberId] = isNull(@memberId, [MemberId]), 
			--[MemberName] = isNull(@memberName, [MemberName]), 
			--[MemberRole] = isNull(@memberRole, [MemberRole]), 
			--[MemberGrade] = isNull(@memberGrade, [MemberGrade]), 
			[Done] = isNull(@done, [Done]), 
			--[Created] = isNull(@created, [Created]), 
			[LastAccessPage] = isNull(@lastAccessPage, [LastAccessPage]), 
			[LastAccessTime] = getdate()
			--[CourseId] = isNull(@courseId, [CourseId]), 
			--[CourseTeacherId] = isNull(@courseTeacherId, [CourseTeacherId]), 
			--[CourseTeacherName] = isNull(@courseTeacherName, [CourseTeacherName]), 
			--[CourseYear] = isNull(@courseYear, [CourseYear]), 
			--[CourseSeme] = isNull(@courseSeme, [CourseSeme]), 
			--[CourseGrade] = isNull(@courseGrade, [CourseGrade]), 
			--[CourseRole] = isNull(@courseRole, [CourseRole])

		where [Number] = @number 

	end
		-- 以下移至 sp_Record_Create
		/*
	else
	begin
		Insert into [dbo].[Record] (
			[PublishNumber], 
			[SurveyNumber], 
			[Guid], 
			--[DepartmentId], 
			--[TargetNumber], 
			[TargetMark], 
			[MemberId], 
			[MemberName], 
			[MemberRole], 
			[MemberGrade], 
			[Done], 
			[Created], 
			[LastAccessPage]
			 
			[CourseId], 
			[CourseTeacherId], 
			[CourseTeacherName], 
			[CourseYear], 
			[CourseSeme], 
			[CourseGrade], 
			[CourseRole]
		) values (
			@publishNumber, 
			 @surveyNumber, 
			 newid(), -- @guid, 
			 @departmentId, 
			 --@targetNumber, 
			 @targetMark, 
			 @memberId, 
			 @memberName, 
			 @memberRole, 
			 @memberGrade, 
			 0, --@done, 
			 getdate(), --@created, 
			 1 --@lastAccessPage, 
			 @courseId, 
			 @courseTeacherId, 
			 @courseTeacherName, 
			 @courseYear, 
			 @courseSeme, 
			 @courseGrade, 
			 @courseRole
		)
	end
	 */

END

