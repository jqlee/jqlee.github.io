-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SurveyUser_GetAvailableListByGroup
	-- Add the parameters for the stored procedure here
	@surveyNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select m.Id, m.Name, gm.MemberId , t.Number as [TargetNumber]
	from GroupSurvey gs 
	inner join v_GroupMember gm on gm.GroupId = gs.GroupId
	inner join v_Member m on m.Id = gm.MemberId
	left outer join TargetGroupMember t on t.GroupId = gm.GroupId and t.MemberId = gm.MemberId
	where gs.SurveyNumber = @surveyNumber and t.Number is null

END
