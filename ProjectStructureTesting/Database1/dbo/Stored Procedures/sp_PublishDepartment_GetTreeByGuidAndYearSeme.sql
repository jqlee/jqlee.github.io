-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PublishDepartment_GetTreeByGuidAndYearSeme]
	-- Add the parameters for the stored procedure here
	@publishNumber int = 0
	,@publishGuid uniqueidentifier 
	,@year smallint
	,@seme tinyint
	,@memberId varchar(20) = null
	,@uiculture varchar(20) = null
	,@showAll bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 	if (@publishNumber = 0 and @publishGuid <> dbo.fn_EmptyGuid())
	begin
		select @publishNumber = Number from PublishSetting where [Guid] = @publishGuid
	end

	begin
   -- Insert statements for procedure here
	select Convert(bit,isNull(pd.PublishNumber,0)) as Checked
	, dt.Id as DepartmentId, dt.Name as [DepartmentName], dt.ParentId, dt.Depth, dt.[Root]
	, pd.Seme
	, (select [Text] from dbo.fn_GetiCanSeme(pd.DepartmentId,@uiculture, Convert(varchar, pd.Seme))) as SemeText
	, dt.ChildCount
	--查學年期的課程數
	, (select Count(*) from v_Group where DepartmentId = d.Id and [Year] = @year and [Seme] = @seme) as [GroupCount]
	from fnDepartmentTree(@memberId) dt
	left outer join PublishDepartment pd on pd.DepartmentId = dt.Id and pd.PublishNumber = @publishNumber
	inner join v_Department d on d.Id = dt.Id

	where isNull(pd.PublishNumber,0) >= (1-@showAll) and HasRole = 1
	order by dt.[Path]
	end

END

/*
select top 10 * from PublishSetting order by Number desc
select  [Year],[Seme],Count(*) from v_Group Group by [Year],[Seme] order by Count(*) desc

declare @publishNumber int = 130
,@publishGuid uniqueidentifier  = '5E2B7C2E-EAB6-473F-9A81-7E10DB5AEF6A'
,@year smallint = 99
,@seme tinyint = 2
,@memberId varchar(20) = 'chchen'
,@uiculture varchar(20) = 'tw'
,@showAll bit = 1
--select * from fnDepartmentTree('chchen')
exec sp_PublishDepartment_GetTreeByGuidAndYearSeme @publishNumber, @publishGuid, @year, @seme, @memberId ,@uiculture, @showAll





SELECT * FROM fnDepartmentTree('ATCHAO')

select [Guid],* from PublishSetting where Number in (110,112,106,103,102,101)

declare @guid uniqueidentifier = 'B2F28BB8-4C97-4D15-A55F-E67210C4FA8B'
exec sp_PublishDepartment_GetListByGuid @publishGuid=@guid
exec sp_PublishDepartment_GetTreeByGuid @publishGuid=@guid,@memberId='atchao',@uiculture='zh-tw'

	SELECT pd.* , d.Name as DepartmentName
	, (select [Text] from dbo.fn_GetiCanSeme(d.SchoolId,d.Id,'', Convert(varchar, pd.Seme))) as SemeText
	from PublishSetting ps
	inner join PublishDepartment pd on pd.PublishNumber = ps.Number
	inner join v_Department d on d.Id = pd.DepartmentId
	where ps.[Guid] = @guid
	order by d.Id,d.name

select * from fn_GetiCanSemeList('1000','CBNTR','')

select * from v_Department
*/