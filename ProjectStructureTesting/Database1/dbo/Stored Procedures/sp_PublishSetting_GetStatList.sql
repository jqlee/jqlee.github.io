
Create PROCEDURE [dbo].[sp_PublishSetting_GetStatList]
	@memberId varchar(20) = null
	,@isPublished bit = null
	,@keyword varchar(50) = null
	,@targetMark tinyint = null
	,@periodYear smallint = null
	,@periodSeme tinyint = null
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	st.Title as TemplateTitle, sc.Name as ScoreConfigName, ps.*
	, ss.RecordCount, ss.CompleteCount, ss.TotalCount
	FROM [dbo].[PublishSetting] ps
	inner join v_SurveyStatus ss on ss.SurveyId = ps.[Guid]
	left outer join (
		Select distinct d.PublishNumber 
		from [PublishDepartment] d
		inner join dbo.fnDepartmentPermission(@memberId) p on p.DepartmentId = d.DepartmentId
	) pp on pp.PublishNumber = ps.Number
	left outer join [SurveyPaper] st on st.[Guid] = ps.TemplateId
	left outer join [ScoreConfig] sc on sc.Number = ps.ScoreConfigNumber
	where ps.[Enabled] = 1 
	--and (pp.PublishNumber is not null or ps.creator = @memberId)
	and 1 = (case when @isPublished is null then 1 when [IsPublished] = @isPublished then 1 else 0 end)
	and 1 = (case when @targetMark is null then 1 when [TargetMark] = @targetMark then 1 else 0 end)
	and 1 = (case when @periodYear is null then 1 when [PeriodYear] = @periodYear then 1 else 0 end)
	and 1 = (case when @periodSeme is null then 1 when [PeriodSeme] = @periodSeme then 1 else 0 end)
	and 1 = (case when @keyword is null then 1 when ps.Name like '%'+@keyword+'%' then 1 else 0 end)
	and 1 = (case when @memberId is null then 1 when pp.PublishNumber is not null or ps.creator = @memberId then 1 else 0 end)
	order by ps.CloseDate desc

END

--exec sp_PublishSetting_GetList 'atchao'
--exec sp_PublishSetting_GetList @memberId='atchao',@isPublished=1
--exec sp_PublishSetting_GetList @memberId='atchao',@isPublished=1,@targetMark=1
--exec sp_PublishSetting_GetList @memberId='atchao',@isPublished=1,@targetMark=2,@periodYear=97,@periodSeme=1
--exec sp_PublishSetting_GetList @memberId='atchao',@isPublished=1,@targetMark=2,@periodYear=98,@periodSeme=1

--exec sp_PublishSetting_GetList @keyword='98年'
--select * from  dbo.fnDepartmentPermission('atchao');


--select * from v_SurveyStatus