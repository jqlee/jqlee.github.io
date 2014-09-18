-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyTarget_GetGroupList]
	-- Add the parameters for the stored procedure here
	@surveyNumber int
	,@groupId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT t.Number, t.SurveyNumber, t.GroupId as TargetTag, t.Name as TargetName 
	from TargetDepartmentGroup t
	where t.SurveyNumber = @surveyNumber and t.GroupId = @groupId
END
