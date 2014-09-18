-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp___ican5_create_tempdata
	-- Add the parameters for the stored procedure here

AS
BEGIN
	SET NOCOUNT ON;

	--下方註解列是回復命令

	update ican5.dbo.college set up_coll = left(coll_no,2) where len(coll_no) = 5
	--update ican5.dbo.college  set up_coll = null

	insert into ican5.dbo.PermGroupCollege (group_no,coll_no,createman,createdate) values 
	('CmCr','ST','_CHCLEE',getdate())
	,('CmCr','PB','_CHCLEE',getdate())
	,('CmCr','SW','_CHCLEE',getdate())
	,('CmCr','SC','_CHCLEE',getdate())
	--delete from ican5.dbo.PermGroupCollege where len(coll_no) = 2

	INSERT INTO [iCAN5].[dbo].[College]
	([coll_no],[schl_id],[coll_name],[coll_shortname],[coll_address],[coll_phone],[coll_weburl],[coll_contactman],[coll_email],[coll_memo],[createdate]
	,[createman],[updatedate],[updateman],[coll_logo],[coll_logotype],[coll_mark],[coll_startdate],[coll_enddate],[up_coll])
	 VALUES
	('_A','2000',N'測試A','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,null)
	,('Test01','2000',N'測試1','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'_A')
	,('Test02','2000',N'測試2','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'_A')
	,('Test03','2000',N'測試3','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'_A')
	,('Test04','2000',N'測試4','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'_A')
	,('_B','2000',N'測試','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,null)
	,('Test05','2000',N'測試5','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'_B')
	,('Test06','2000',N'測試6','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'_B')
	,('Test07','2000',N'測試7','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'_B')
	,('Node01','2000',N'測試x1','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'Test02')
	,('Node02','2000',N'測試x2','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'Test02')
	,('Node03','2000',N'測試x3','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'Node02')
	,('Node04','2000',N'測試x4','TN1',null,null,null,null,null,null,getdate(),'_chclee',getdate(),'_chclee',null,null,'10',null,null,'Node03')
	--Delete from [iCAN5].[dbo].[College] where [schl_id] <> '1000'

END
