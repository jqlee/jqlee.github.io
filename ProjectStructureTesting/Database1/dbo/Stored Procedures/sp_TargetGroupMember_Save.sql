
CREATE PROCEDURE [dbo].[sp_TargetGroupMember_Save]
	@surveyNumber int
	,@groupId varchar(20)
	,@memberId varchar(20)
	,@name nvarchar(50) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[TargetGroupMember] where [SurveyNumber] = @surveyNumber and [GroupId] = @groupId and [MemberId] = @memberId ))
	begin
		 return; 
	end
	else
	begin
		
		Insert into [dbo].[TargetGroupMember] (
			[SurveyNumber], 
			[GroupId], 
			[MemberId],
			[Name]
		) values (
			 @surveyNumber, 
			 @groupId, 
			 @memberId,
			 @name
		)

	end
END


