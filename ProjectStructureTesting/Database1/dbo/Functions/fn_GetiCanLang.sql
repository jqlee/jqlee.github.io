-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetiCanLang]
(	
	-- Add the parameters for the function here
	@schoolId varchar(6)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select para_no as [Number], schl_id as SchoolId, para_phsiname as [Value], para_dispname as [Text], para_no as SortOrder 
	from fn_GetiCanPara(@schoolId,'p_lang')
)
