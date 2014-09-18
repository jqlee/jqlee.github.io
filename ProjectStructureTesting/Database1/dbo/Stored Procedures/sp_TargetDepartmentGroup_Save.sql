
CREATE PROCEDURE [dbo].[sp_TargetDepartmentGroup_Save]
	@surveyNumber int
	,@groupId varchar(20)
	,@includingAuditor bit = null
	,@name nvarchar(50) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[TargetDepartmentGroup] where [SurveyNumber] = @surveyNumber and [GroupId] = @groupId ))
	begin
		
		Update [dbo].[TargetDepartmentGroup] set 
			[IncludingAuditor] = isNull(@includingAuditor, [IncludingAuditor])
			,[Name] = isNull(@name, [Name])
		where [SurveyNumber] = @surveyNumber and [GroupId] = @groupId

	end
	else
	begin
		
		Insert into [dbo].[TargetDepartmentGroup] (
			[SurveyNumber], 
			[GroupId], 
			[IncludingAuditor],
			[Name]
		) values (
			 @surveyNumber, 
			 @groupId, 
			 @includingAuditor,
			 @name
		)

	end
END


