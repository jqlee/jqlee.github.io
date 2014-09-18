-- 只看最新100筆
CREATE PROCEDURE [dbo].[sp_PublishSetting_GetRecycleList]
	@memberId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	top 100 ps.*
	FROM  [dbo].[PublishSetting] ps
	left outer join (
		Select distinct d.PublishNumber from [PublishDepartment] d
		inner join dbo.fnDepartmentPermission(@memberId) p on p.DepartmentId = d.DepartmentId
	) pp on pp.PublishNumber = ps.Number 
	where ps.[Enabled] = 0 and [IsTemporary] = 0
	--and ps.creator = @memberId
	order by ps.[RecycleDate] desc
END

--exec sp_PublishSetting_GetList 'atchao'
--exec sp_PublishSetting_GetList @memberId='atchao',@isPublished=1
--exec sp_PublishSetting_GetList @memberId='atchao',@isPublished=1,@targetMark=1
--exec sp_PublishSetting_GetList @memberId='atchao',@isPublished=1,@targetMark=2,@periodYear=97,@periodSeme=1
--exec sp_PublishSetting_GetList @memberId='atchao',@isPublished=1,@targetMark=2,@periodYear=98,@periodSeme=1


/*
select * from [PublishSetting]

declare @memberId varchar(20) = 'chchen'
	SELECT 
	top 100 ps.*
	FROM  [dbo].[PublishSetting] ps
	left outer join (Select distinct d.PublishNumber from [PublishDepartment] d
	inner join dbo.fnDepartmentPermission(@memberId) p on p.DepartmentId = d.DepartmentId) pp on pp.PublishNumber = ps.Number 
	where ps.[Enabled] = 0 
	order by ps.[RecycleDate] desc


	update SurveyPaper set DefaultLangCode = 'CN' where [Guid] = 'adc4b382-6ba9-4f50-87f5-e560a110c560'
	 select * from fn_GetiCanLang('1000')  order by [SortOrder]


*/