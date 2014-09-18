-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyTicket_GetPagedGroupCompleteRateList]
	-- Add the parameters for the stored procedure here
	@publishGuid uniqueidentifier
	,@keyword nvarchar(max) = null
	,@sortExpressions nvarchar(max) = null
	,@startRowIndex int = 0
	,@maximumRows int = 20
	,@recordCount int output
AS
BEGIN

	SET NOCOUNT ON;

	if (@sortExpressions is null or @sortExpressions = '') set @sortExpressions = 'RecordCount desc'
	if (@keyword is not null) set @keyword = ltrim(rtrim(@keyword));

	declare @sql nvarchar(max);
	set @sql = dbo.fn_GeneratePagedSql(
	'(select ps.[Guid] as PublishGuid, r.RecordCount, r.CompleteCount, r.TotalCount
	, Convert(float,case when r.TotalCount>0 then Convert(float,r.CompleteCount)/r.TotalCount else 0 end) as CompleteRate
	, t.* 
	from PublishSetting ps
	inner join dbo.v_Ticket t on t.PublishNumber = ps.Number
	inner join (
			select PublishNumber,GroupId,GroupTeacherId,GroupRole
			, SUM(CASE WHEN RecordNumber IS NOT NULL THEN 1 ELSE 0 END) AS RecordCount
			, SUM(CASE WHEN RecordDone = 1 THEN 1 ELSE 0 END) AS CompleteCount
			, count(MemberId) as TotalCount
			 from v_MatchRecord
			 group by PublishNumber,GroupId,GroupTeacherId,GroupRole
		) r on r.PublishNumber = ps.Number and r.GroupId = t.GroupId and r.GroupTeacherId = t.GroupTeacherId and r.GroupRole = t.GroupRole
	) x' --table
	, '*' --reutrn columns
	, @sortExpressions --'[LastModified] desc' --sortExpressions
	, ' where PublishGuid = @publishGuid 
	and 1 = case 
		when @keyword is null then 1 
		when @keyword is not null and (
			GroupId like ''%''+@keyword+''%'' or GroupName like ''%''+@keyword+''%''
			or GroupTeacherId like ''%''+@keyword+''%'' or GroupTeacherName like ''%''+@keyword+''%''
			or GroupDepartmentId like ''%''+@keyword+''%'' or GroupDepartmentName like ''%''+@keyword+''%''
		) then 1 
		else 0 end
	' --where conditions
	)
	--print @sql;
	EXECUTE sp_executesql @sql, N'@publishGuid uniqueidentifier,@keyword nvarchar(max) = null,@sortExpressions nvarchar(max) = null,@startRowIndex int = 0,@maximumRows int = 20,@recordCount int output'
		,@publishGuid=@publishGuid,@keyword=@keyword,@sortExpressions=@sortExpressions,@startRowIndex=@startRowIndex, @maximumRows=@maximumRows, @recordCount=@recordCount out


END
/*
declare @publishGuid uniqueidentifier = 'fcd65a8d-5a82-484c-aaa9-14a81f4581cc'
	,@keyword nvarchar(max) = '1001CBNDD2D10101'
	,@sortExpressions nvarchar(max) = null
	,@startRowIndex int = 0
	,@maximumRows int = 0
exec sp_SurveyTicket_GetPagedGroupCompleteRateList @publishGuid=@publishGuid,@keyword=@keyword,@recordCount=0



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