
Create PROCEDURE [dbo].[sp_TargetForGroup_ResetGroup]
	@surveyNumber int = null
	,@groupId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;
	
	begin tran T1
	Delete FROM [dbo].[TargetForGroup] where [SurveyNumber] = @surveyNumber;

	insert into [dbo].[TargetForGroup] (SurveyNumber, GroupId, TargetMark)
	values (@surveyNumber, @groupId, 1);

	update Survey set TargetMark = 1 where Number = @surveyNumber;

	commit tran T1

END

