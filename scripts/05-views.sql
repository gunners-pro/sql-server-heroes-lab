use HeroesLab
go

create or alter view vw_heroes_full
as select hr.id, hr.[name], hr.appearances, hr.[year], pb.[description] as publisher, al.[description] as alignment,
ec.[description] as eye_color, hc.[description] as hair_color, sx.[description] as sex, [as].[description] as alive_status
from Heroes as hr
inner join publishers as pb on pb.id = hr.publisher_id
left join alignments as al on al.id = hr.alignment_id
left join eyecolors as ec on ec.id = hr.eye_color_id
left join haircolors as hc on hc.id = hr.hair_color_id
left join sexes as sx on sx.id = hr.sex_id
left join alivestatus as [as] on [as].id = hr.alive_status_id
go

select * from vw_heroes_full
go

create or alter view vw_heroes_summary
as select 
	publisher, 
	count(*) as total_heroes,
	sum(case when alive_status = 'Living Characters' then 1 else 0 end) as living_count,
	sum(case when alignment = 'Good Characters' then 1 else 0 end) as good_count,
	sum(case when alignment = 'Bad Characters' then 1 else 0 end) as bad_count,
	sum(case when alignment = 'Neutral Characters' then 1 else 0 end) as neutral_count,
	avg(appearances) as avg_appearances
from vw_heroes_full
group by publisher
go

select * from vw_heroes_summary
go

create or alter view vw_iconic_heroes
as select id, [name], publisher, appearances, alignment
from vw_heroes_full
where appearances >= 1000 and alive_status = 'Living Characters'
go

select * from vw_iconic_heroes
go