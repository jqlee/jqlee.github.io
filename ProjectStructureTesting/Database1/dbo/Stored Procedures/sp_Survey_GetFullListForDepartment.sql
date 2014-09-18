--
-- 20130820: 有問卷管理身分的可以編修所有問卷，把權限部分拿掉
--
CREATE PROCEDURE [dbo].[sp_Survey_GetFullListForDepartment]
	--@managerId varchar(20) = null,
	@stateMark tinyint = null
	,@visible bit = 1
	,@enabled bit = null
	,@progress tinyint = null
AS
BEGIN
	SET NOCOUNT ON;

	if (@stateMark = 0) set @stateMark = null;

	select --@managerId as [CurrentUser]
	--, m.Name as [OwnerName]
	null as [CurrentUser]
	, null as [OwnerName]
	, s.*
	from Survey s
/*
	left outer join (
	  SELECT t.SurveyNumber from dbo.fnRoleDepartment(@managerId) rd
	  inner join TargetForDepartment t on t.DepartmentId = rd.Id
	  group by t.SurveyNumber
	) ts on ts.SurveyNumber = s.Number

	inner join v_Member m on m.Id = s.[Owner]
*/
	where s.GroupOnly = 0 and s.[StateMark] = isNull(@stateMark,s.[StateMark])
/*
	and ( 
		(s.[Owner] = @managerId and s.Visible = @visible)
		 or 
		(s.[Owner] <> @managerId and s.[StateMark] = 3 and s.[Enabled] = 1 and s.[Visible] = 1)
	)
*/
	and s.[Enabled] = isNull(@enabled,s.[Enabled])
	and s.[Visible] = @visible
	and case 
		when @progress = 0 then 1 
		when @progress = 1 and s.[StateMark] = 3 and getdate() < s.[StartDate] then 1 
		when @progress = 2 and s.[StateMark] = 3 and getdate() between s.[StartDate] and s.[EndDate] then 1 
		when @progress = 3 and s.[StateMark] = 3 and getdate() > s.[EndDate] then 1 
		else 0
		end = 1

	order by s.EndDate desc, s.Name
END

/*
select @managerId as [CurrentUser],m.Name as OwnerName,* from Survey s
inner join (
  SELECT t.SurveyNumber from 
  dbo.fnRoleDepartment('hhtsai') rd
  inner join TargetForDepartment t on t.DepartmentId = rd.Id
  group by t.SurveyNumber
) ts on ts.SurveyNumber = s.Number
inner join v_Member m on m.Id = s.Owner
where s.GroupOnly = 0 


and s.[StateMark] = isNull(@stateMark,s.[StateMark]) and s.Visible = @visible


exec [sp_Survey_GetListForDepartment] 'hhtsai'


update Survey set Owner = creator where Owner is null
select * from Survey where Owner <> Creator

select * from survey where [Guid]='c66d9cb6-965d-4937-9b72-9d5e8f6ae607'


s
*/