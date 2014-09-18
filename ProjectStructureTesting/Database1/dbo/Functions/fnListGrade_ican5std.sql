-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create FUNCTION [dbo].[fnListGrade_ican5std]
(	
	-- Add the parameters for the function here
	
)
RETURNS TABLE 
AS
RETURN 
(

	--std
	SELECT para_no as Number, para_phsiname as Value, para_dispname as Name 
	from ican5_std.dbo.ican_para_muti where para_code = 'p_grade'

)
