
CREATE PROCEDURE [dbo].[sp_Survey_ChangeTargetMark]
	@number int = 0
	,@targetMark tinyint
AS
BEGIN
	SET NOCOUNT ON;

	begin tran T1
	--清空舊條件

	exec sp_Condition_DeleteBySurvey @number

	--exec sp_TargetForDepartment_DeleteBySurvey @surveyNumber=@number;
	
	Update [dbo].[Survey] set [TargetMark] = @targetMark where [Number] = @number 

	commit tran T1

END


