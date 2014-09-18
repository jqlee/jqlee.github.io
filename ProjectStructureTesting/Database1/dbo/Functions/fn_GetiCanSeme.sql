-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetiCanSeme]
(	
	-- Add the parameters for the function here
	@departmentId varchar(20)
	,@uiculture varchar(10) -- 最多支援10位，譬如 bs-Cyrl-BA、az-Latn-AZ
	,@semeValue varchar(10)
)
RETURNS TABLE 
AS
RETURN 
(
	-- @culture 目前至少有支援三種: [zh-tw | zh-cn | en-us]

	-- Add the SELECT statement with parameter references here
	select *
	from fn_GetiCanSemeList(@departmentId, @uiculture)
	where [Value] = @semeValue
)
