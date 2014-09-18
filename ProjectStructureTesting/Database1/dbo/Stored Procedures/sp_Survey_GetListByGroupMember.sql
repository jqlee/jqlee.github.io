-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Survey_GetListByGroupMember]
	-- Add the parameters for the stored procedure here
	@groupId varchar(20)
	,@memberId varchar(20)
	,@stateMark tinyint = 3
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--declare @groupId varchar(20), @memberId varchar(20)
	--set @groupId = '1001CBNTR20D57002';
	--set @memberId = '98652516';
select x.* from (
	Select 2 as [TargetMark], s.[Number], s.[Name], s.[Title], s.[GroupOnly], s.[GroupId], s.[Description], s.[IsEnableHtml], s.[StartDate], s.[EndDate], s.[TotalReturn], s.[ResultOpen], s.[PageCount], s.[StateMark], s.[Enabled], s.[Creator], s.[Created], s.[CreatorName],s. [LastModified], s.[LastModifier], s.[LastModifierName], s.[CanAnswerTimes], s.[Language], s.[Guid], s.[CreateItemType], s.[CreateItemNumber]
	from [Survey] s
	inner join [TargetDepartmentGroup] t on t.[SurveyNumber] = s.[Number]
	inner join [v_GroupMember] cs on cs.[GroupId] = t.[GroupId]
	where s.[GroupOnly] = 1 and cs.[MemberId] = @memberId and cs.GroupId = @groupId and s.[StateMark] = @stateMark
	union all
	Select 3 as [TargetMark], s.[Number], s.[Name], s.[Title], s.[GroupOnly], s.[GroupId], s.[Description], s.[IsEnableHtml], s.[StartDate], s.[EndDate], s.[TotalReturn], s.[ResultOpen], s.[PageCount], s.[StateMark], s.[Enabled], s.[Creator], s.[Created], s.[CreatorName],s. [LastModified], s.[LastModifier], s.[LastModifierName], s.[CanAnswerTimes], s.[Language], s.[Guid], s.[CreateItemType], s.[CreateItemNumber]
	from [Survey] s
	inner join [TargetGroupMember] t on t.[SurveyNumber] = s.[Number]
	where s.[GroupOnly] = 1 and t.[MemberId] = @memberId and t.GroupId = @groupId and s.[StateMark] = @stateMark
) x
order by [EndDate], [StartDate]

END
