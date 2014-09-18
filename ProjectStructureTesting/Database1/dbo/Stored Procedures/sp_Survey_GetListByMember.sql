-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Survey_GetListByMember]
	-- Add the parameters for the stored procedure here
	@memberId varchar(20)
	,@stateMark tinyint = 3
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
	Select x.*,m.[Note] from (
		Select  s.* --1 as [TargetMark],
		from [Survey] s
		inner join [TargetDepartment] t on t.[SurveyNumber] = s.[Number]
		inner join [v_Member] m on m.[DepartmentId] =isNull( t.[DepartmentId],m.[DepartmentId])
			and m.[Grade] = isNull(t.[Level], m.[Grade]) 
			--and s.[CollGroup] = isNull(t.[CollGroup], s.[CollGroup])
		where s.[GroupOnly] = 0 and m.[Id] = @memberId and s.[StateMark] = @stateMark
		union all
		Select s.* --2 as [TargetMark],
		from [Survey] s
		inner join [TargetDepartmentGroup] t on t.[SurveyNumber] = s.[Number]
		inner join [v_GroupMember] cs on cs.[GroupId] = t.[GroupId]
		where s.[GroupOnly] = 0 and cs.[MemberId] = @memberId and s.[StateMark] = @stateMark
		union all
		Select s.*  --3 as [TargetMark], 
		from [Survey] s
		inner join [TargetGroupMember] t on t.[SurveyNumber] = s.[Number]
		where s.[GroupOnly] = 0 and t.[MemberId] = @memberId and s.[StateMark] = @stateMark
		union all
		Select s.* --distinct 4 as [TargetMark], 
		from [Survey] s
		inner join [TargetGroupDepartmentByYear] t on t.[SurveyNumber] = s.[Number]
		inner join [v_DepartmentGroup] c on c.[Year] = t.[GroupYear] and c.[DepartmentId] = t.[DepartmentId]
		inner join [v_GroupMember] cs on cs.[GroupId] = c.[Id]
		where s.[GroupOnly] = 0 and cs.[MemberId] = @memberId and s.[StateMark] = @stateMark
	) x inner join [SysMark] m on m.[Name] = 'TargetMark' and m.[Value] = x.[TargetMark]
	order by [EndDate], [StartDate]



END

