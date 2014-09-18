-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create FUNCTION [dbo].[fn_GetiCanParaWithLangArea_ican5std]
(	
	-- Add the parameters for the function here
	@schoolId varchar(6)
	,@para_code varchar(20)
	,@langArea char(2)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	--select * from iCAN5_STD.dbo.udf_GetIcanPara(@schoolId,@para_code)
	-- std版要join Parameter 取回語系字串
	select 
	m.schl_id, m.para_code, m.para_phsiname, m.para_no
	,isNull(p.lang_dispname, m.para_dispname) as para_dispname --, para_dispname
	, m.para_dispname_1000, m.para_dispname_2000, m.para_dispname_3000
	, m.para_imgname, para_group, m.para_logrecord, m.para_langid
	from iCAN5_STD.dbo.udf_GetIcanPara(@schoolId,@para_code) m 
	left join iCAN5_STD.dbo.[Parameters] p on p.lang_guid = m.para_dispname and p.lang_type = @langArea


)
