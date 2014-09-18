﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create FUNCTION [dbo].[fnConditionTargetMatch]
(	
	-- Add the parameters for the function here
	@conditionNumber int
)
RETURNS @t TABLE ([SurveyNumber] int,[TargetMark] tinyint, [DepartmentId] varchar(20), [MatchKey] varchar(100), [MatchName] nvarchar(100), [GroupId] varchar(20) null, [MemberGrade] int null, 
		[MemberId] varchar(20), [RoleCode] varchar(6), [RecordNumber] int, [RecordDone] bit)
begin
	declare @tm tinyint
	select @tm = s.TargetMark from survey s 
	inner join [Condition] c on c.SurveyNumber = s.Number
	where c.Number = @conditionNumber

	if (@tm = 1 or @tm = 4)
	begin
		insert into @t ([SurveyNumber], [TargetMark], [DepartmentId], [MatchKey], [MatchName], [GroupId], [MemberGrade], [MemberId], [RoleCode],[RecordNumber],[RecordDone])
		SELECT t.SurveyNumber, @tm as TargetMark, t.DepartmentId, t.MatchKey, t.MatchName
			, gm.GroupId, NULL AS MemberGrade, gm.MemberId, gm.[RoleCode]
			, r.Number as RecordNumber, r.Done as RecordDone
			FROM (
				Select distinct ct.TargetNumber from [ConditionTarget] ct
				inner join [Target] t on t.Number = ct.TargetNumber
				where ct.ConditionNumber = @conditionNumber
			) ct -- dbo.Survey AS s
			inner join dbo.[Target] AS t ON t.Number = ct.TargetNumber --t.[SurveyNumber] = s.[Number]
			left outer join (
				select gm.GroupId, gm.MemberId, gm.[RoleCode] 
				from dbo.v_GroupMember AS gm 
				inner join dbo.v_Member m ON m.[Id] = gm.[MemberId] AND m.[Enabled] = 1
				where gm.[Enabled] = 1
			) gm ON gm.[GroupId] = t.[GroupId] AND gm.[RoleCode] = t.[RoleCode]
			left outer join Record r on r.SurveyNumber = t.SurveyNumber and r.MatchKey = t.MatchKey and r.MemberId = gm.MemberId

		--where s.[Number] = @surveyNumber and s.[TargetMark] = @tm
	end
	else
	begin
		insert into @t ([SurveyNumber],[TargetMark], [DepartmentId], [MatchKey], [MatchName], [GroupId], [MemberGrade], [MemberId], [RoleCode],[RecordNumber],[RecordDone])
		SELECT t.SurveyNumber, @tm as TargetMark, m.DepartmentId, t.MatchKey, t.MatchName, NULL AS GroupId, m.Grade AS MemberGrade, m.Id AS MemberId, m.RoleCode
			, r.Number as RecordNumber, r.Done as RecordDone
			FROM (
				Select distinct ct.TargetNumber from [ConditionTarget] ct
				inner join [Target] t on t.Number = ct.TargetNumber
				where ct.ConditionNumber = @conditionNumber
			) ct -- dbo.Survey AS s
			INNER JOIN dbo.[Target] AS t ON t.Number = ct.TargetNumber --t.[SurveyNumber] = s.[Number]
			INNER JOIN dbo.fnGetGradeList() AS gl ON gl.[Value] = t.[MemberGrade]
			left outer JOIN dbo.v_Member AS m ON m.[DepartmentId] = t.[DepartmentId] AND m.[Grade] = t.[MemberGrade] AND m.[Enabled] = 1 AND m.[RoleCode] = t.[RoleCode] 
			left outer join Record r on r.SurveyNumber = t.SurveyNumber and r.MatchKey = t.MatchKey and r.MemberId = m.Id
		--where s.[Number] = @surveyNumber and s.[TargetMark] = @tm

	end

	return
end

