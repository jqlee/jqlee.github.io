CREATE PROCEDURE [dbo].[sp_PublishSetting_GetStatPagedList]
	@memberId varchar(20) = null
	,@isPublished bit = null
	,@keyword varchar(50) = null
	,@targetMark tinyint = 0
	,@periodYear smallint = 0
	,@periodSeme tinyint = 0
	,@sortExpressions nvarchar(max) = 'OpenDate desc'
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'(
	SELECT 
		st.Title as TemplateTitle, pp.PublishNumber --,sc.Name as ScoreConfigName
		, ps.*
		--, ss.RecordCount, ss.CompleteCount, ss.TotalCount
		, pr.PublishedIndexNumber
		FROM [dbo].[PublishSetting] ps
		--inner join v_SurveyStatus ss on ss.PublishNumber = ps.Number
		left outer join (
			Select distinct d.PublishNumber 
			from [PublishDepartment] d
			inner join dbo.fnDepartmentPermission(@memberId) p on p.DepartmentId = d.DepartmentId
		) pp on pp.PublishNumber = ps.Number
		left outer join [SurveyPaper] st on st.[PublishNumber] = ps.Number and st.[PublishVersion] = ps.[LastPublishVersion]
		--left outer join [ScoreConfig] sc on sc.Number = ps.ScoreConfigNumber
		left outer join (
			select sc.PublishNumber, rsi.Number as PublishedIndexNumber
			from RecordScoreIndex rsi
			inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
			where rsi.IsPublished = 1
			group by sc.PublishNumber, rsi.Number
		) pr on pr.PublishNumber = ps.Number
		where ps.[Enabled] = 1 and ps.IsPublished = 1 and ps.TargetMark = 1
		and (ps.Number is not null or ps.Creator = @memberId)
		and 1 = (case when @isPublished is null then 1 when ps.[IsPublished] = @isPublished then 1 else 0 end)
		and 1 = (case when @targetMark = 0 or @targetMark = 0 then 1 when ps.[TargetMark] = @targetMark then 1 else 0 end)
		and 1 = (case when @periodYear = 0 then 1 when ps.[PeriodYear] = @periodYear then 1 else 0 end)
		and 1 = (case when @periodSeme = 0 then 1 when ps.[PeriodSeme] = @periodSeme then 1 else 0 end)
		and 1 = (case when @keyword is null then 1 when ps.Name like ''%''+@keyword+''%'' then 1 else 0 end)
		and 1 = (case when @memberId is null then 1 when ps.Number is not null or ps.Creator = @memberId then 1 else 0 end)
	) x ' --table
	, '*' --reutrn columns
	, @sortExpressions --sortExpressions
	, '
	' --where conditions
	)

	--print @sql

	EXECUTE sp_executesql @sql
		, N'@memberId varchar(20), @sortExpressions nvarchar(max)
		,@isPublished bit, @targetMark tinyint
		,@periodYear smallint,@periodSeme tinyint
		,@keyword varchar(50)
		,@startRowIndex int,@maximumRows int , @recordCount int output'
		,@memberId=@memberId,@sortExpressions=@sortExpressions
		,@isPublished=@isPublished,@targetMark=@targetMark
		,@periodYear=@periodYear,@periodSeme=@periodSeme
		,@keyword=@keyword
		,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out
END

-- exec sp_PublishSetting_GetStatPagedList @memberId='atchao',@recordCount=0

/*
 exec sp_PublishSetting_GetStatPagedList @memberId='chchen',@recordCount=0

 select top 2 * from v_SurveyStatus

declare @memberId varchar(20) = 'chchen'
select * 
FROM [dbo].[PublishSetting] ps
inner join (
	Select distinct d.PublishNumber 
	from [PublishDepartment] d
	inner join dbo.fnDepartmentPermission(@memberId) p on p.DepartmentId = d.DepartmentId
) pp on pp.PublishNumber = ps.Number
inner join v_SurveyStatus ss on ss.PublishNumber = ps.Number


Update PublishSetting set CompleteCount = ss.CompleteCount
	, PublishCount = ss.TotalCount
	, CompleteRate = Convert(float, case when ss.TotalCount > 0 then Convert(float,ss.CompleteCount) / ss.TotalCount else 0 end)
from PublishSetting ps
inner join v_SurveyStatus ss on ss.PublishNumber = ps.Number
where PublishCount is null


Select distinct d.PublishNumber 
from [PublishDepartment] d
inner join dbo.fnDepartmentPermission(@memberId) p on p.DepartmentId = d.DepartmentId

update PublishSetting set PublishCount = 0 where PublishCount is null
update PublishSetting set CompleteCount = 0 where CompleteCount is null
update PublishSetting set CompleteRate = 0 where CompleteRate is null


select * from PublishSetting where Name = '建築學系期中課程滿意度調查'

select * from PublishSetting
declare @memberId varchar(20) = 'chchen'
	,@isPublished bit = 1
	,@keyword varchar(50) = null
	,@targetMark tinyint = 0
	,@periodYear smallint = 100
	,@periodSeme tinyint = 1
	,@sortExpressions nvarchar(max) = 'OpenDate desc'
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int = 0

	exec [dbo].[sp_PublishSetting_GetStatPagedList] @memberId,@isPublished,@keyword,@targetMark,@periodYear,@periodSeme,@sortExpressions,@startRowIndex,@maximumRows,@recordCount

select * from v_SurveyStatus where SurveyNumber = 114

select * from v_SurveyStatus where PublishNumber = 114


SELECT SurveyId, SurveyNumber, SUM(CASE WHEN RecordNumber IS NOT NULL THEN 1 ELSE 0 END) AS RecordCount
, SUM(CASE WHEN RecordDone = 1 THEN 1 ELSE 0 END) AS CompleteCount, COUNT(MemberId) AS TotalCount
FROM dbo.v_SurveyMatch
 where SurveyNumber = 114
GROUP BY   SurveyId, SurveyNumber


	where ps.[Enabled] = 1 and ps.IsPublished = 1
	and (ps.Number is not null or ps.Creator = @memberId)
	and 1 = (case when @isPublished is null then 1 when ps.[IsPublished] = @isPublished then 1 else 0 end)
	and 1 = (case when @targetMark = 0 or @targetMark = 0 then 1 when ps.[TargetMark] = @targetMark then 1 else 0 end)
	and 1 = (case when @periodYear = 0 then 1 when ps.[PeriodYear] = @periodYear then 1 else 0 end)
	and 1 = (case when @periodSeme = 0 then 1 when ps.[PeriodSeme] = @periodSeme then 1 else 0 end)
	and 1 = (case when @keyword is null then 1 when ps.Name like ''%''+@keyword+''%'' then 1 else 0 end)
	and 1 = (case when @memberId is null then 1 when ps.Number is not null or ps.Creator = @memberId then 1 else 0 end)

	where [Enabled] = 1 and IsPublished = 1
	and (PublishNumber is not null or Creator = @memberId)
	and 1 = (case when @isPublished is null then 1 when [IsPublished] = @isPublished then 1 else 0 end)
	and 1 = (case when @targetMark = 0 or @targetMark = 0 then 1 when [TargetMark] = @targetMark then 1 else 0 end)
	and 1 = (case when @periodYear = 0 then 1 when [PeriodYear] = @periodYear then 1 else 0 end)
	and 1 = (case when @periodSeme = 0 then 1 when [PeriodSeme] = @periodSeme then 1 else 0 end)
	and 1 = (case when @keyword is null then 1 when Name like ''%''+@keyword+''%'' then 1 else 0 end)
	and 1 = (case when @memberId is null then 1 when PublishNumber is not null or Creator = @memberId then 1 else 0 end)

    SET NOCOUNT ON;
	begin
		SELECT @recordCount = COUNT(*) 
		FROM (
	SELECT 
	st.Title as TemplateTitle, sc.Name as ScoreConfigName, pp.PublishNumber
	, ps.*
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
	) x 
			where [Enabled] = 1 
	and (PublishNumber is not null or Creator = @memberId)
	and 1 = (case when @isPublished is null then 1 when [IsPublished] = @isPublished then 1 else 0 end)
	and 1 = (case when @targetMark = 0 or @targetMark = 0 then 1 when [TargetMark] = @targetMark then 1 else 0 end)
	and 1 = (case when @periodYear = 0 then 1 when [PeriodYear] = @periodYear then 1 else 0 end)
	and 1 = (case when @periodSeme = 0 then 1 when [PeriodSeme] = @periodSeme then 1 else 0 end)
	and 1 = (case when @keyword is null then 1 when Name like '%'+@keyword+'%' then 1 else 0 end)
	and 1 = (case when @memberId is null then 1 when PublishNumber is not null or Creator = @memberId then 1 else 0 end)
	
	end

	BEGIN
		with [TempTable] as (
			Select ROW_NUMBER() OVER (ORDER BY OpenDate desc) AS [RowNumber]
				,*
			from (
				SELECT 
				st.Title as TemplateTitle, sc.Name as ScoreConfigName, pp.PublishNumber
				, ps.*
				, ss.RecordCount, ss.CompleteCount, ss.TotalCount
				, pr.PublishedIndexNumber
				FROM [dbo].[PublishSetting] ps
				inner join v_SurveyStatus ss on ss.SurveyId = ps.[Guid]
				left outer join (
					Select distinct d.PublishNumber 
					from [PublishDepartment] d
					inner join dbo.fnDepartmentPermission(@memberId) p on p.DepartmentId = d.DepartmentId
				) pp on pp.PublishNumber = ps.Number
				left outer join [SurveyPaper] st on st.[Guid] = ps.TemplateId
				left outer join [ScoreConfig] sc on sc.Number = ps.ScoreConfigNumber
				left outer join (
					select sc.PublishNumber, rsi.Number as PublishedIndexNumber
					from RecordScoreIndex rsi
					inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
					where rsi.IsPublished = 1
					group by sc.PublishNumber, rsi.Number
				) pr on pr.PublishNumber = ps.Number
			) x 
			where [Enabled] = 1 
			and (PublishNumber is not null or Creator = @memberId)
			and 1 = (case when @isPublished is null then 1 when [IsPublished] = @isPublished then 1 else 0 end)
			and 1 = (case when @targetMark = 0 or @targetMark = 0 then 1 when [TargetMark] = @targetMark then 1 else 0 end)
			and 1 = (case when @periodYear = 0 then 1 when [PeriodYear] = @periodYear then 1 else 0 end)
			and 1 = (case when @periodSeme = 0 then 1 when [PeriodSeme] = @periodSeme then 1 else 0 end)
			and 1 = (case when @keyword is null then 1 when Name like '%'+@keyword+'%' then 1 else 0 end)
			and 1 = (case when @memberId is null then 1 when PublishNumber is not null or Creator = @memberId then 1 else 0 end)
		)
		SELECT *
		FROM [TempTable]
		WHERE [RowNumber] between @startRowIndex+1 and @startRowIndex+@maximumRows
	end;
	
*/