
CREATE PROCEDURE [dbo].[sp_PublishTarget_Save]
	@number int
	,@publishNumber int = null
	,@groupYear smallint = null
	,@groupSeme tinyint = null
	,@groupGrade tinyint = null
	,@groupRole varchar(6) = null
	,@memberGrade tinyint = null
	,@memberRole varchar(6) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[PublishTarget] where [Number] = @number ))
	begin
		
		Update [dbo].[PublishTarget] set 
			[PublishNumber] = isNull(@publishNumber, [PublishNumber]), 
			[GroupYear] = isNull(@groupYear, [GroupYear]), 
			[GroupSeme] = isNull(@groupSeme, [GroupSeme]), 
			[GroupGrade] = isNull(@groupGrade, [GroupGrade]), 
			[GroupRole] = isNull(@groupRole, [GroupRole]), 
			[MemberGrade] = isNull(@memberGrade, [MemberGrade]), 
			[MemberRole] = isNull(@memberRole, [MemberRole])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[PublishTarget] (
			[PublishNumber], 
			[GroupYear], 
			[GroupSeme], 
			[GroupGrade], 
			[GroupRole], 
			[MemberGrade], 
			[MemberRole]
		) values (
			 @publishNumber, 
			 @groupYear, 
			 @groupSeme, 
			 @groupGrade, 
			 @groupRole, 
			 @memberGrade, 
			 @memberRole
		)

	end
END

