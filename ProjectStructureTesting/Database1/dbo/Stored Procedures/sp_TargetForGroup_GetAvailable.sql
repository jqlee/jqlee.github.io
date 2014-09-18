-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- returns [GroupId, MemberId, Name]
CREATE PROCEDURE [dbo].[sp_TargetForGroup_GetAvailable] 
	
	@surveyNumber int = 0
	,@groupId varchar(20) = null
	, @targetMark tinyint = 1
AS
BEGIN
	SET NOCOUNT ON;

	if @targetMark = 1 
	begin
		select g.Id as GroupId, null as MemberId, g.Name
		 from v_DepartmentGroup g
		 left outer join [TargetForGroup] t on t.GroupId = g.Id and t.SurveyNumber = @surveyNumber 
		 where g.Id = @groupId --and t.SurveyNumber is null
	end
	else if @targetMark = 2
	begin
		select gm.GroupId as GroupId, m.Id as MemberId
		,m.Id+' '+m.Name as Name
		from v_GroupMember gm
		inner join v_Member m on m.Id = gm.MemberId
		 left outer join [TargetForGroup] t on t.GroupId = gm.GroupId and t.MemberId = gm.MemberId and t.SurveyNumber = @surveyNumber 
		where gm.GroupId = @groupId and t.SurveyNumber is null
	end
END
