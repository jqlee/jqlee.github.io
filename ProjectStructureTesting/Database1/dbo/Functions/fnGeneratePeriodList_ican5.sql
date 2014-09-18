-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	依照傳入的起始值(與今年差距)與數量產生學年期清單
/*
select * from ican5.dbo.ican_para where para_code = 'p_semenow'
select * from ican5.dbo.ican_para where para_code = 'p_sememark'
select * from ican5.dbo.ican_para where para_code = 'p_seme'
*/
-- =============================================
CREATE FUNCTION fnGeneratePeriodList_ican5
(	
	-- Add the parameters for the function here
	@init int = -5
	, @count int = 10
)
RETURNS @t Table ([Id] int identity(1,1), [YearValue] int, [DisplayYear] int, [Seme] int,[SemeName] nvarchar(10), [IsCurrent] bit)
begin
	-- Add the SELECT statement with parameter references here
	

	declare @i int = 0;
	declare @needMask bit;
	declare @current int = 0;


	select @needMask = convert(bit, case para_phsiname when 10 then 1 else 0 end)
	from ican5.dbo.ican_para where para_code = 'p_sememark'


	while (@i<@count)
	begin
		set @current = Year(getdate())+@i+@init
		insert into @t ([YearValue],[DisplayYear],[Seme],[SemeName] ,[IsCurrent]) 
		/*
		values (
			@current, 
			case @needMask when 1 then @current-1911 else @current end,
			case @i+@init when 0 then 1 else 0 end
		)*/
		select @current
			, case @needMask when 1 then @current-1911 else @current end
			, a.para_phsiname
			, a.para_dispname
			/* , case @i+@init when 0 then 1 else 0 end*/
			, 0
			from ican5.dbo.ican_para a where a.para_code = 'p_seme'

		set @i = @i + 1;
	end

	declare @nowseme varchar(6) = null;
	select @nowseme = para_phsiname from ican5.dbo.ican_para where para_code = 'p_semenow';
	update @t set [IsCurrent] = 1 
	where CONVERT(varchar, [DisplayYear]) + CONVERT(varchar, [Seme])  = @nowseme;

	return;
end
