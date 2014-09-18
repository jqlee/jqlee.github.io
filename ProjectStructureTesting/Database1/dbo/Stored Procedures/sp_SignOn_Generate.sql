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

CREATE PROCEDURE [dbo].[sp_SignOn_Generate]
	-- Add the parameters for the stored procedure here
	@managerLevel tinyint = 0
	,@isTeacher bit = 0
	,@isStudent bit = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @man_user char(4)
	declare @man_no varchar(20)
	declare @course_no varchar(20)
	declare @sessionId varchar(32)

	select @man_user = case @managerLevel 
	when 0 then '10' 
	when 1 then '20' 
	when 2 then '40' 
	when 3 then '70' 
	when 4 then '80' 
	else '00' end + '00'

	select top 1 @man_no = man_no from ican5.dbo.Man where [man_user] = @man_user order by newid()
	set @sessionId = LOWER(REPLACE(convert(char(36),newid()),'-',''));

	declare @temp Table (idx int identity(1,1), course_no varchar(20), man_no varchar(20) )

	if (@isTeacher = 1)
	begin

		insert into @temp (course_no, man_no)
			select top 1 ms.course_no, m.man_no 
			from ican5.dbo.Man m
			inner join ican5.dbo.ManScore ms on ms.man_no = m.man_no
			where m.[man_user] = @man_user and left(ms.manscore_type,2) = '20'
			 order by newid()
		select @man_no = man_no, @course_no = course_no from @temp;

	end
	else if (@isStudent = 1)
	begin
		insert into @temp (course_no, man_no)
			select top 1 ms.course_no,m.man_no
			from ican5.dbo.Man m
			inner join ican5.dbo.ManScore ms on ms.man_no = m.man_no
			where m.[man_user] = @man_user and left(ms.manscore_type,2) = '10'
			 order by newid()
		select @man_no = man_no, @course_no = course_no from @temp;
	end
	else
	begin
		set @man_no = (
			select top 1 man_no from ican5.dbo.Man where [man_user] = @man_user order by newid()
		)
	end

	/*
	update SignOn 
	set signon_mark = 40
	where DATEDIFF(minute, createdate, GETDATE()) < 10
	*/

	insert into SignOn (sessionid, man_no, man_user, course_no, signon_mark, createdate)
	select @sessionId, @man_no, @man_user, @course_no, 20, getdate()


	select * from SignOn where sessionid = @sessionId
	/*
	signon_mark

	20 已使用
	40 無效
	*/

	

END
