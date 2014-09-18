-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create FUNCTION [dbo].[fnListGrade_ican5]
(	
	-- Add the parameters for the function here
	
)
RETURNS TABLE 
AS
RETURN 
(

	--sce
	SELECT para_no as Number, para_phsiname as Value, para_dispname as Name 
	from ican5.dbo.ican_para where para_code = 'p_grade'

)
