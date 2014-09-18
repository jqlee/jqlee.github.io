﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	回傳兩欄 [Text] 與 [Value]
-- =============================================
CREATE FUNCTION [dbo].[fn_GetiCanGradeList]
(	
	-- Add the parameters for the function here
	@schollId varchar(6)
	,@uiculture varchar(10) -- 最多支援10位，譬如 bs-Cyrl-BA、az-Latn-AZ
)
RETURNS TABLE 
AS
RETURN 
(
	-- @culture 目前至少有支援三種: [zh-tw | zh-cn | en-us]
	select *
	from fn_GetiCanGradeList_ican5(@schollId, @uiculture)

)
