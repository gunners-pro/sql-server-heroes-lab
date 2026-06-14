use HeroesLab
go

create or alter function fn_classify_appearances(@appearances int)
returns varchar(20)
as
begin
	declare @result varchar(20)

	if @appearances is null or @appearances < 100
		set @result = 'Rookie'
	else if @appearances >= 100 and @appearances < 1000
		set @result = 'Veteran'
	else
		set @result = 'Legend'
	return @result
end
go

select top 5 [name], appearances, dbo.fn_classify_appearances(appearances) as [classification]
from heroes
order by appearances desc
go

create or alter function fn_heroes_by_classification(@classification varchar(20))
returns table
as
return (
	select [name], publisher, appearances
	from vw_heroes_full
	where dbo.fn_classify_appearances(appearances) = @classification
)
go

SELECT * FROM fn_heroes_by_classification('Rookie')
go