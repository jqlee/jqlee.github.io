
CREATE PROCEDURE [dbo].[sp_Condition_Save]
	@number int
	,@surveyNumber int = null
	,@targetMark tinyint = null
	,@keyword varchar(20) = null
	,@groupYear int = null
	,@roleCode varchar(6) = null
	,@memberGrade int = null
	,@name nvarchar(50) = null
	,@creator varchar(20) = null
	,@created datetime = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Condition] where [Number] = @number ))
	begin
		
		Update [dbo].[Condition] set 
			[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			[TargetMark] = isNull(@targetMark, [TargetMark]), 
			[Keyword] = isNull(@keyword, [Keyword]), 
			[GroupYear] = isNull(@groupYear, [GroupYear]), 
			[RoleCode] = isNull(@roleCode, [RoleCode]), 
			[MemberGrade] = isNull(@memberGrade, [MemberGrade]), 
			[Name] = isNull(@name, [Name]), 
			[Creator] = isNull(@creator, [Creator]), 
			[Created] = isNull(@created, [Created])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[Condition] (
			[SurveyNumber], 
			[TargetMark], 
			[Keyword], 
			[GroupYear], 
			[RoleCode], 
			[MemberGrade], 
			[Name], 
			[Creator], 
			[Created]
		) values (
			 @surveyNumber, 
			 @targetMark, 
			 @keyword, 
			 @groupYear, 
			 @roleCode, 
			 @memberGrade, 
			 @name, 
			 @creator, 
			 @created
		)

	end
END

