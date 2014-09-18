﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetiCanSemeList_ican5std]
(	
	-- Add the parameters for the function here
	@departmentId varchar(20)
	,@uiculture varchar(10) -- 最多支援10位，譬如 bs-Cyrl-BA、az-Latn-AZ
)
RETURNS TABLE 
AS
RETURN 
(
	-- @culture 目前至少有支援三種: [zh-tw | zh-cn | en-us]

	-- Add the SELECT statement with parameter references here
	select para_phsiname as [Value], lang_dispname as [Text]
	from ican5_std.dbo.udf_GetCollegeCodeByLang(@departmentId, 'p_seme', @uiculture)
)