
CREATE PROCEDURE [dbo].[sp_Survey_GetListByMaster]
	@masterId varchar(20) = null
	,@groupId varchar(20) = null
	,@visible bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	if (@groupId is null)
	begin
		select s.[Number], s.[Name], s.[Title], s.[GroupOnly], s.[GroupId], s.[Description], s.[IsEnableHtml], s.[StartDate], s.[EndDate], s.[TotalReturn], s.[ResultOpen], s.[PageCount], s.[StateMark], s.[Enabled], s.[Creator], s.[Created], s.[CreatorName],s. [LastModified], s.[LastModifier], s.[LastModifierName], s.[CanAnswerTimes], s.[Language], s.[Guid], s.[CreateItemType], s.[CreateItemNumber]
		, m.Note as [StateNote] 
		from Survey s
		 left outer join [SysMark] m on m.Name='StateMark' and m.Value = s.StateMark
		where s.[Creator] = @masterId
			and s.[GroupOnly] = 0
			and case 
				when @visible = 1 and (s.[StateMark] >= 1 and s.[StateMark] <= 4) then 1
				when @visible = 0 and (s.[StateMark] = 5) then 1 -- 6:刪除 => 不顯示
				else 0 end = 1
		
	end
	else
	begin
		select s.[Number], s.[Name], s.[Title], s.[GroupOnly], s.[GroupId], s.[Description], s.[IsEnableHtml], s.[StartDate], s.[EndDate], s.[TotalReturn], s.[ResultOpen], s.[PageCount], s.[StateMark], s.[Enabled], s.[Creator], s.[Created], s.[CreatorName],s. [LastModified], s.[LastModifier], s.[LastModifierName], s.[CanAnswerTimes], s.[Language], s.[Guid], s.[CreateItemType], s.[CreateItemNumber]
		, m.Note as [StateNote] 
		from  [GroupSurvey] gs
			inner join Survey s on s.Number = gs.SurveyNumber
		 left outer join [SysMark] m on m.Name='GroupState' and m.Value = s.StateMark
		where s.[Creator] = @masterId
			and gs.GroupId = @groupId
			and s.[GroupOnly] = 1
			and case 
				when @visible = 1 and (s.[StateMark] >= 1 and s.[StateMark] <= 4) then 1
				when @visible = 0 and (s.[StateMark] = 5) then 1 -- 6:刪除 => 不顯示
				else 0 end = 1
		
	end
END

