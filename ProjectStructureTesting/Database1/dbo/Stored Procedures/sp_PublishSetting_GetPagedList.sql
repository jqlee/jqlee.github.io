CREATE PROCEDURE [dbo].[sp_PublishSetting_GetPagedList]
	@memberId varchar(20) = null
	,@targetMark tinyint = null
	,@enabled bit = null
	,@isPublished bit = null
	,@statusMark tinyint = 0
	,@proccessingStatus tinyint = 0
	,@periodYear smallint = null
	,@periodSeme tinyint = null
	,@sortExpressions nvarchar(max) = 'LastModified desc'
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	--若參數型別對應到.net的實值型別，並且參數允許null，請務必檢查is null並給預設值
	--if (@int is null) set @int = -1; 

	if (@sortExpressions is null or @sortExpressions = '') set @sortExpressions = 'LastModified desc'
	-- 將 sortExpressoins 補上資料表前綴 ps
	declare @t Table ([Value] nvarchar(max))
	insert into @t
	select (select 'ps.'+[Value]+ ',' AS [text()]
		from dbo.fnSplit(@sortExpressions,',') For XML PATH ('')
	) as [Value] 
	select @sortExpressions = Left([Value],Len([Value])-1) from @t
	set @sortExpressions = replace(@sortExpressions,'ps.TemplateTitle','st.Title');
	--print @sortExpressions

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'[dbo].[PublishSetting] ps
	left outer join (Select distinct d.PublishNumber from [PublishDepartment] d
	inner join dbo.fnDepartmentPermission(@memberId) p on p.DepartmentId = d.DepartmentId) pp on pp.PublishNumber = ps.Number 
	left outer join [SurveyPaper] st on st.[Guid] = ps.TemplateId
	left outer join [SurveyPaper] spt on spt.PublishNumber = ps.Number and spt.PublishVersion = ps.LastPublishVersion
	left outer join [ScoreConfig] sc on sc.Number = ps.ScoreConfigNumber ' --table
	, '
	(select count(*) from v_SurveyMatch where SurveyNumber = pp.PublishNumber) as UserCount
	, ps.*
	, sc.Name as ScoreConfigName
	, st.Number as TemplateNumber ,st.Title as TemplateTitle
	, spt.[Guid] as PublishedTemplateId, spt.Number as PublishedTemplateNumber, spt.Title as PublishedTemplateTitle
	' --reutrn columns
	, @sortExpressions --sortExpressions
	, 'where (pp.PublishNumber is not null or ps.creator = @memberId)
	and TargetMark = 1
	and 1 = (case 
		when @proccessingStatus = 0 then 1 
		when @proccessingStatus = 1 and getdate() < OpenDate then 1
		when @proccessingStatus = 2 and getdate() between OpenDate and CloseDate then 1
		when @proccessingStatus = 3 and getdate() > CloseDate then 1
		else 0
		end
	)
	and 1 = (case when @enabled is null then 1 when ps.[Enabled] = @enabled then 1 else 0 end)
	and 1 = (case when @isPublished is null then 1 when [IsPublished] = @isPublished then 1 else 0 end)
	and 1 = (case when @targetMark is null then 1 when [TargetMark] = @targetMark then 1 else 0 end)
	and 1 = (case when @periodYear is null then 1 when [PeriodYear] = @periodYear then 1 else 0 end)
	and 1 = (case when @periodSeme is null then 1 when [PeriodSeme] = @periodSeme then 1 else 0 end)
	and 1 = (case 
		when @statusMark = 1 and IsPublished = 0 and (IsDoneProperty = 0  or IsDoneConfig = 0) then 1 --編輯中
		when @statusMark = 2 and IsPublished = 0 and (IsDoneProperty = 1 and IsDoneConfig = 1) then 1 --編輯完成
		when @statusMark = 3 and IsPublished = 1 then 1 --已發布
		when @statusMark = 4 and IsPaused = 1 then 1 --已暫停(過期的沒有暫不暫停的問題)
		when @statusMark = 0 then 1 --不限
		else 0 end)
	' --where conditions
	)

	--print @sql

	EXECUTE sp_executesql @sql
		, N'@memberId varchar(20), @sortExpressions nvarchar(max), @enabled bit, @isPublished bit, @targetMark tinyint
		,@statusMark tinyint,@proccessingStatus tinyint,@periodYear smallint,@periodSeme tinyint
		,@startRowIndex int,@maximumRows int , @recordCount int output'
		,@memberId=@memberId,@sortExpressions=@sortExpressions,@enabled=@enabled,@isPublished=@isPublished,@targetMark=@targetMark
		,@statusMark=@statusMark,@proccessingStatus=@proccessingStatus,@periodYear=@periodYear,@periodSeme=@periodSeme
		,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

-- exec sp_PublishSetting_GetPagedList @memberId='atchao',@recordCount=0,@proccessingStatus=0