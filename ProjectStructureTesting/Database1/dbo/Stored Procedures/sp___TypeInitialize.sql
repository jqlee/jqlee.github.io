-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp___TypeInitialize
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	if (not exists( select 0 from sys.types where name = 'DataMapping'))
	CREATE TYPE DataMapping AS TABLE (
		Id int identity(1,1) PRIMARY KEY
		,[numberFrom] int null
		,[toNumber] int null
		,[stringFrom] varchar(max) null
		,[toString] varchar(max) null
	);
	select * from sys.types where name = 'DataMapping'

END
