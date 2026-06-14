use HeroesLab
go

create or alter procedure usp_get_heroes_by_alignment
	@alignment varchar(255)
as
begin
	set nocount on
	select [name], publisher, appearances, alive_status
	from vw_heroes_full
	where alignment = @alignment
	order by appearances desc
end
go

exec usp_get_heroes_by_alignment 'Bad Characters'
go

create or alter procedure usp_insert_hero
	@name varchar(255),
	@publisher varchar(50),
	@alignment varchar(50) = null,	
	@appearances int = null,
	@year int = null
as
begin
	set nocount on
	declare @publisher_id int
	declare @alignment_id int

	select @publisher_id = id
	from publishers
	where [description] = @publisher

	if @publisher_id is null
	begin
		raiserror('Publisher not found: %s', 16, 1, @publisher)
		return
	end

	select @alignment_id = id
	from alignments
	where [description] = @alignment

	insert into heroes ([name], publisher_id, alignment_id, appearances, [year])
	values (@name, @publisher_id, @alignment_id, @appearances, @year)
end
go

alter table heroes
alter column page_id int null
go

exec usp_insert_hero @name = 'Teste', @publisher = 'Marvel', @alignment = 'Good Characters', @appearances = 100, @year = 2024
go

select * from heroes
where [name] = 'Teste'
go

create or alter procedure usp_heroes_summary_report
as
begin
	set nocount on
	select count(*) as total_heroes
	from vw_heroes_full
	select publisher, count(*) as total_heroes_by_publisher
	from vw_heroes_full
	group by publisher
	select [name]
	from vw_heroes_full
	where appearances = (select max(appearances) from vw_heroes_full)
end
go

exec usp_heroes_summary_report
go