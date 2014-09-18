-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	傳入群組與問卷編號查詢成員
-- =============================================
Create PROCEDURE [dbo].[sp_Member_GetMemberListByGroupSurvey]
	-- Add the parameters for the stored procedure here
	@groupId varchar(20)
	,@surveyNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select gm.GroupId, gm.GroupRoleValue, gm.GroupRoleExtensionValue, m.* 
	, t.SurveyNumber, Convert(bit,case when t.SurveyNumber is null then 0 else 1 end) as [Checked]
	from v_GroupMember gm
	inner join v_MemberWithDepartment m on m.Id = gm.MemberId
	left outer join TargetGroupMember t on t.GroupId = gm.GroupId and t.MemberId = gm.MemberId
	and t.SurveyNumber = @surveyNumber
	where gm.GroupId = @groupId and gm.GroupRoleValue = 10

END
