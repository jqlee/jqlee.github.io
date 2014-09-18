-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyMatch_GetUserPagedList]
	-- Add the parameters for the stored procedure here
	@surveyId uniqueidentifier
	,@keyword nvarchar(max) = null
	,@sortExpressions nvarchar(max) = null
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int output
AS
BEGIN

	SET NOCOUNT ON;

	if (@sortExpressions is null or @sortExpressions = '') set @sortExpressions = 'RecordCreated desc'

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'(select ps.Name as PublishName, ps.TargetMark, ps.[Enabled] as PublishEnabled, ps.IsPublished
	, ps.PeriodYear, ps.PeriodSeme, ps.Period, ps.OpenDate, ps.CloseDate,mr.* from PublishSetting ps
inner join v_MatchRecord mr on mr.PublishNumber = ps.Number where ps.[Guid] = @surveyId) x' --table
	, '*' --reutrn columns
	, @sortExpressions --'[LastModified] desc' --sortExpressions
	, ' where 1 = case
			when @keyword is null then 1 
			when @keyword is not null and (MemberId like ''%''+@keyword+''%'' or MemberName like ''%''+@keyword+''%'') then 1 
			when @keyword is not null and TargetMark = 1 and (GroupId like ''%''+@keyword+''%'' or GroupName like ''%''+@keyword+''%'' or GroupTeacherId like ''%''+@keyword+''%'' or GroupTeacherName like ''%''+@keyword+''%'') then 1 
			else 0 end
	' --where conditions
	)
	--print @sql;
	EXECUTE sp_executesql @sql, N'@surveyId uniqueidentifier,@keyword nvarchar(max) = null,@sortExpressions nvarchar(max) = null,@startRowIndex int = 0,@maximumRows int = 20,@recordCount int output'
		,@surveyId=@surveyId,@keyword=@keyword,@sortExpressions=@sortExpressions,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out


END
/*
declare @surveyId uniqueidentifier = 'fcd65a8d-5a82-484c-aaa9-14a81f4581cc'
	,@keyword nvarchar(max) = '1001CBNTR30D56403'
	,@sortExpressions nvarchar(max) = null
	,@startRowIndex int = 0
	,@maximumRows int = 20
exec sp_SurveyMatch_GetUserPagedList @surveyId=@surveyId,@keyword=@keyword,@recordCount=0

select mr.* from PublishSetting ps
inner join v_MatchRecord mr on mr.PublishNumber = ps.Number
where ps.[Guid] = @surveyId

		and 1 = case
			when @keyword is null then 1 
			when @keyword is not null and (MemberId like '%'+@keyword+'%' or MemberName like '%'+@keyword+'%') then 1 
			when @keyword is not null and TargetMark = 1 and (GroupId like '%'+@keyword+'%' or GroupName like '%'+@keyword+'%' or GroupTeacherId like '%'+@keyword+'%' or GroupTeacherName like '%'+@keyword+'%') then 1 
			else 0 end




*/