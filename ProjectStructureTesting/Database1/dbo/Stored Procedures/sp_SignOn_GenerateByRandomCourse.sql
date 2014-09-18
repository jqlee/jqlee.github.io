-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

/* managerLevel man_user 
	4	8000 系統
	3	7000 校管理
	2	4000 教務
	1	2010 助教
	1	2000 老師
	0	1010 旁聽
	0	1000 學生
*/

CREATE PROCEDURE [dbo].[sp_SignOn_GenerateByRandomCourse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @sessionId varchar(32)
	set @sessionId = LOWER(REPLACE(convert(char(36),newid()),'-',''));

	declare @course_no varchar(20)
	set @course_no = (
		select top 1 course_no from ican5.dbo.ManScore group by course_no having  count(*) > 30 order by newid()
	)
	--select @course_no

	declare @temp Table (idx int identity(1,1), course_no varchar(20), man_no varchar(20), man_user char(4) )
	insert into @temp (course_no, man_no, man_user)
		select top 1 ms.course_no, m.man_no, m.man_user
		from ican5.dbo.Man m
		inner join ican5.dbo.ManScore ms on ms.man_no = m.man_no
		where ms.course_no = @course_no and left(ms.manscore_type,2) = '20' 
		order by newid()
		
	insert into @temp (course_no, man_no, man_user)
		select top 5 ms.course_no, m.man_no, m.man_user
		from ican5.dbo.Man m
		inner join ican5.dbo.ManScore ms on ms.man_no = m.man_no
		where ms.course_no = @course_no and left(ms.manscore_type,2) = '10' 
		order by newid()
		
	--select * from @temp
	insert into SignOn (sessionid, man_no, man_user, course_no, signon_mark, createdate)
	select @sessionId, man_no, man_user, course_no, 20, getdate()
	from @temp;

	select * from SignOn where sessionid = @sessionId
	/*
	signon_mark

	20 已使用
	40 無效
	*/

	

END
