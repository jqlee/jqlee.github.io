
CREATE PROCEDURE [dbo].[sp_TargetForGroup_Save]
	@number int
	,@surveyNumber int = null
	,@groupId varchar(20) = null
	,@memberId varchar(20) = null
	,@creator varchar(20) = null
	,@targetMark tinyint = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[TargetForGroup] where [Number] = @number ))
	begin
		
		Update [dbo].[TargetForGroup] set 
			[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			[GroupId] = isNull(@groupId, [GroupId]), 
			[MemberId] = isNull(@memberId, [MemberId]), 
			[Creator] = isNull(@creator,[Creator]),
			[TargetMark] = isNull(@targetMark, [TargetMark])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[TargetForGroup] (
			[SurveyNumber], 
			[GroupId], 
			[MemberId], 
			[Creator],
			[TargetMark]
		) values (
			 @surveyNumber, 
			 @groupId, 
			 @memberId, 
			 @creator,
			 @targetMark
		)

	end
END

