-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PublishSetting_GetListForTeacher]
	-- Add the parameters for the stored procedure here
	@teacherId varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ps.* 
	, pr.PublishedIndexNumber
	from PublishSetting ps
	inner join (
		select PublishNumber from v_Ticket 
		where [GroupTeacherId] = @teacherId
		group by PublishNumber
	) st on st.PublishNumber = ps.Number
	inner join (
		select sc.PublishNumber, rsi.Number as PublishedIndexNumber
		from RecordScoreIndex rsi
		inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
		where rsi.IsPublished = 1
		group by sc.PublishNumber, rsi.Number
	) pr on pr.PublishNumber = ps.Number
	where TargetMark=1 and [Enabled] = 1 and [IsPublished] = 1
END


/*
declare @teacherId varchar(20) = 'T9100229'
	select ps.* 
	, pr.PublishedIndexNumber
	from PublishSetting ps
	inner join (
		select PublishNumber from v_Ticket 
		where [GroupTeacherId] = @teacherId
		group by PublishNumber
	) st on st.PublishNumber = ps.Number
	inner join (
		select sc.PublishNumber, rsi.Number as PublishedIndexNumber
		from RecordScoreIndex rsi
		inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
		where rsi.IsPublished = 1
		group by sc.PublishNumber, rsi.Number
	) pr on pr.PublishNumber = ps.Number
	where TargetMark=1 and [Enabled] = 1 and [IsPublished] = 1


exec sp_PublishSetting_GetListForTeacher @teacherId

*/