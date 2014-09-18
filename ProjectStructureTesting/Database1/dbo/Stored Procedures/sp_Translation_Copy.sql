-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Translation_Copy
	-- Add the parameters for the stored procedure here
	@category varchar(20) = null -- 
	,@dataNumber int
	,@newDataNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into PaperLanguageText ([LangNumber], [CategoryNumber], [DataNumber], [DataValue])
	select pt.[LangNumber], pt.[CategoryNumber], @newDataNumber as [DataNumber], pt.[DataValue] 
	from PaperLanguageText pt
	inner join PaperLanguageCategory pc on pc.Number = pt.CategoryNumber and pc.Name = @category
	where pt.[DataNumber] = @dataNumber

END
