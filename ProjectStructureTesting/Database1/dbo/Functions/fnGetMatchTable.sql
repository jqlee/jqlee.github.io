-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetMatchTable] 
(	
	-- Add the parameters for the function here
	@surveyNumber int
)
RETURNS @Table table ([Index] int identity(1,1), [TargetMark] tinyint, [MatchKey] varchar(50), [MatchName] nvarchar(max) )
begin
	-- Add the SELECT statement with parameter references here
	declare @targetMark tinyint

	SELECT @targetMark = TargetMark FROM Survey WHERE Number = @surveyNumber

	if (@targetMark =2 or @targetMark = 3)
		insert into @Table ([TargetMark],[MatchKey],[MatchName]) 
		select @targetMark as TargetMark, Id as [MatchKey], Name as [MatchName] from v_Department
	else
		insert into @Table ([TargetMark],[MatchKey],[MatchName]) 
		select @targetMark as TargetMark, Id as [MatchKey], Name as [MatchName] from v_DepartmentGroup

	return
end


/*
declare @matchKey varchar(20)


declare @surveyNumber int
set @surveyNumber = 1

declare @targetMark tinyint

SELECT @targetMark = TargetMark FROM Survey WHERE Number = @surveyNumber

if (@targetMark >2)
	select @targetMark as TargetMark, Id as [MatchKey], Name as [MatchName] from v_Department
else
	select @targetMark as TargetMark, Id as [MatchKey], Name as [MatchName] from v_DepartmentGroup

	*/
/*
MatchKey 
*/
