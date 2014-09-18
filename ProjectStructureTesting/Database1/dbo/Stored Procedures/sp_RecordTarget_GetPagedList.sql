
CREATE PROCEDURE [dbo].[sp_RecordTarget_GetPagedList]
	@publishGuid uniqueidentifier
	,@keyword nvarchar(max) = null
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@sortExpressions nvarchar(max) = null
	,@recordCount int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	if (@sortExpressions is null or @sortExpressions = '') set @sortExpressions = '[Number] desc'
	-- 將 sortExpressoins 補上資料表前綴 ps
	declare @t Table ([Value] nvarchar(max))
	insert into @t
	select (select 'rs.'+[Value]+ ',' AS [text()]
		from dbo.fnSplit(@sortExpressions,',') For XML PATH ('')
	) as [Value] 
	select @sortExpressions = Left([Value],Len([Value])-1) from @t
	--set @sortExpressions = replace(@sortExpressions,'ps.TemplateTitle','st.Title');

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'[dbo].[RecordTarget] rs
	inner join [dbo].[RecordScoreIndex] rsi on rsi.Number = rs.[IndexNumber] and rsi.IsPublished = 1
	inner join [dbo].[ScoreConfig] sc on sc.Number = rsi.ConfigNumber
	inner join [dbo].[PublishSetting] ps on ps.Number = sc.PublishNumber' --table
	, 'rs.*' --reutrn columns
	, @sortExpressions --sortExpressions
	, '	where ps.[Guid] = @publishGuid
	and 1 = (case when @keyword is null then 1 
		when (rs.GroupId like ''%''+@keyword+''%'') 
			or (rs.GroupName like ''%''+@keyword+''%'') 
			or (rs.GroupTeacherId like ''%''+@keyword+''%'') 
			or (rs.GroupTeacherName like ''%''+@keyword+''%'') 
			or (rs.GroupDepartmentId like ''%''+@keyword+''%'') 
			or (rs.GroupDepartmentName like ''%''+@keyword+''%'') 
			or (rs.GroupSubjectKey like ''%''+@keyword+''%'') 
		then 1 
		else 0 end)
	' --where conditions
	)
	EXECUTE sp_executesql @sql, N'@publishGuid uniqueidentifier,@keyword nvarchar(max) = null, @startRowIndex int,@maximumRows int , @recordCount int output'
		,@publishGuid=@publishGuid,@keyword=@keyword, @startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out

	/*
	SELECT rs.*
	FROM [dbo].[RecordTarget] rs
	inner join [dbo].[RecordScoreIndex] rsi on rsi.Number = rs.[IndexNumber] and rsi.IsPublished = 1
	inner join [dbo].[ScoreConfig] sc on sc.Number = rsi.ConfigNumber
	inner join [dbo].[PublishSetting] ps on ps.Number = sc.PublishNumber
	where ps.[Guid] = @publishGuid
	*/

	--where rsi.[Guid] = @indexGuid

	/*
	select IndexNumber, RecordNumber, sum(Score) as TotalScore 
	from [RecordQuestionScore]
	where [IndexNumber] = isNull(@indexNumber,[IndexNumber])
	group by IndexNumber,RecordNumber
	*/

	/*
	RecordTarget 資料改由 RecordQuestionScore grouping來，不存實體紀錄
	SELECT [Number], [IndexNumber], [RecordNumber], [Score]
	FROM [dbo].[RecordTarget]
	where [IndexNumber] = isNull(@indexNumber,[IndexNumber])
	*/
END
/*
exec sp_RecordTarget_GetPagedList @publishGuid='fcd65a8d-5a82-484c-aaa9-14a81f4581cc',@recordCount=0
*/