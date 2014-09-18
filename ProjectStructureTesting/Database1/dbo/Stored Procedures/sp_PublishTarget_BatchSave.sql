
CREATE PROCEDURE [dbo].[sp_PublishTarget_BatchSave]
	@publishNumber int = 2
	,@targetMark int = 2
	,@groupYears varchar(max)
	--,@groupSemes varchar(max)
	,@groupGrades varchar(max)
	,@groupRoles varchar(max)
	,@memberGrades varchar(max)
	,@memberRoles varchar(max)
AS
BEGIN
	SET NOCOUNT ON;

	begin tran t1
	
		delete from [PublishTarget] where [PublishNumber] = @publishNumber;

		if (@targetMark = 1)
		begin
			Insert into [dbo].[PublishTarget] (
					[PublishNumber], 
					[GroupYear], 
					[GroupGrade], 
					[GroupRole])
			select @publishNumber as [PublishNumber]
			,gy.Value as [GroupYear]
			, gg.Value as [GroupGrade], gr.Value as [GroupRole] 
			from dbo.fnSplit(@groupYears, ',') gy
			, dbo.fnSplit(@groupGrades, ',') gg
			, dbo.fnSplit(@groupRoles, ',') gr
		end


		else if (@targetMark = 2)
		begin
			Insert into [dbo].[PublishTarget] (
					[PublishNumber], 
					[MemberGrade], 
					[MemberRole])
			select @publishNumber as [PublishNumber]
			,case when bg.Value = '' then null else bg.Value end as [MemberGrade], br.Value as [MemberRole]
			from dbo.fnSplit(@memberRoles, ',') br
			, dbo.fnSplit(@memberGrades, ',') bg 
		end

	commit tran t1


END

/*

select * from  dbo.fnSplit('', ',')


declare @publishNumber int = 2
	,@targetMark int = 2
	,@groupYears varchar(max) = '99'
	,@groupGrades varchar(max) = ''
	,@groupRoles varchar(max) = '1000'
select @publishNumber as [PublishNumber]
, gy.Value as [GroupYear]
, gg.Value as [GroupGrade]
, gr.Value as [GroupRole] 
from dbo.fnSplit(@groupYears, ',') gy
, (select * from dbo.fnSplit(@groupGrades, ',') where Value <> '') gg
, dbo.fnSplit(@groupRoles, ',') gr

*/