-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SignOn_Create
	-- Add the parameters for the stored procedure here
	@memberId varchar(20)
	,@manuser char(4) = '1000'
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into SignOn (sessionid, man_no, createdate, man_user, signon_mark)
	values (
		Lower(replace(newid(),'-','')), @memberId, getdate(), @manuser, '20' 
	)
END
