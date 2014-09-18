-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SurveyTarget_AddGroup
	-- Add the parameters for the stored procedure here
	@surveyNumber int
	,@groupId varchar(20)
	,@name nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	delete from TargetGroupMember where SurveyNumber = @surveyNumber and GroupId = @groupId;

	SET NOCOUNT OFF;
    -- Insert statements for procedure here
	insert Into TargetDepartmentGroup (SurveyNumber,GroupId,[Name]) 
	values (@surveyNumber,@groupId,@name)
END
