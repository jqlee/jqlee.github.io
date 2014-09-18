-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PublishSetting_GetYearSemeList]
	-- Add the parameters for the stored procedure here
	@teacherId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * 
	from (
		select distinct ps.* from PublishSetting ps 
		inner join v_Ticket t on t.PublishNumber = ps.Number and t.GroupTeacherId = @teacherId
		where GroupCount > 0
	) ps
	left outer join (
		select ps.Number
		from RecordTarget rs
		inner join RecordScoreIndex rsi on rsi.Number = rs.IndexNumber and rsi.IsPublished = 1
		inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
		inner join PublishSetting ps on ps.Number = sc.PublishNumber
		where rs.GroupTeacherId = @teacherId and getdate() > ps.QueryDate
		group by ps.PeriodYear, ps.PeriodSeme, ps.Number 
	) x on x.Number = ps.Number
	-- where getdate() > ps.QueryDate

	-- 20140522 調整權限
	-- where ps.QueryDate is not null 
	
	order by ps.PeriodYear, ps.PeriodSeme, ps.Name


	/* 查詢規則

     (1) 教學評價的公布日期，可以設定不公布或日期未到，老師會看到該課程評價項目，但是不會顯示分數。

     (2) 若教學評價的公布日期有設定，且已到，老師會看到分數。

     (3) 看到分數不表示可以看到細項題目結果，該細項題目結果需要到設定公開項目功能指定老師可查看的題目。

	
	*/
END
/*
exec sp_PublishSetting_GetYearSemeList 'TA002392'

		select distinct ps.* from PublishSetting ps 
		inner join v_Ticket t on t.PublishNumber = ps.Number and t.GroupTeacherId = 'TA002392'
		where GroupCount > 0
*/