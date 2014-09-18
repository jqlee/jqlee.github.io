﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Survey_GetTemplateList
	-- Add the parameters for the stored procedure here
	@creator varchar(20)
	,@keyword nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Survey where IsTemplate = 1 and Creator = @creator
	order by Name
END
