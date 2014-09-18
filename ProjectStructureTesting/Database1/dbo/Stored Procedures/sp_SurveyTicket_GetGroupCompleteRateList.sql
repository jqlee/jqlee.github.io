-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyTicket_GetGroupCompleteRateList]
	-- Add the parameters for the stored procedure here
	@publishGuid uniqueidentifier
	,@keyword nvarchar(max) = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	if (@keyword ='') set @keyword = null
	if (@keyword is not null)
	 set @keyword = '%'+@keyword+'%';
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select * 
	from (
    -- Insert statements for procedure here
	select ps.[Guid] as PublishGuid,r.RecordCount, r.CompleteCount, r.TotalCount
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
	) x
	where PublishGuid = @publishGuid
	and 1 = case 
		when @keyword is null then 1 
		when @keyword is not null and (
			GroupId like @keyword or GroupName like @keyword
			or GroupTeacherId like @keyword or GroupTeacherName like @keyword
			or GroupDepartmentId like @keyword or GroupDepartmentName like @keyword
		) then 1 
		else 0 end
END
/*
declare @publishGuid uniqueidentifier = '216c2c37-cf98-4911-bab4-4a347e66b957'
exec sp_SurveyTicket_GetGroupCompleteRateList @publishGuid=@publishGuid,@keyword='1001CBNDD2D10101'

		select t.GroupId,t.GroupTeacherId,t.GroupRole
			, SUM(CASE WHEN r.Number IS NOT NULL THEN 1 ELSE 0 END) AS RecordCount
			, SUM(CASE WHEN r.Done = 1 THEN 1 ELSE 0 END) AS CompleteCount
			, COUNT(r.MemberId) AS TotalCount
		from v_Ticket t 
		left outer join Record r on r.GroupId = t.GroupId and r.GroupTeacherId = t.GroupTeacherId and r.GroupRole = t.GroupRole
		group by t.GroupId,t.GroupTeacherId,t.GroupRole

select top 10 * from v_Ticket where PublishNumber = 116

select GroupId,GroupTeacherId,GroupRole
, SUM(CASE WHEN RecordNumber IS NOT NULL THEN 1 ELSE 0 END) AS RecordCount
, SUM(CASE WHEN RecordDone = 1 THEN 1 ELSE 0 END) AS CompleteCount
, count(MemberId) as TotalCount
 from v_MatchRecord
 where PublishNumber = 116 and GroupId = '1001CBNDD2D10101'
 group by GroupId,GroupTeacherId,GroupRole

*/