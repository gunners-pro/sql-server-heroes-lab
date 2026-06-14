select * from
HeroesRaw
go

insert into Heroes (page_id, [name], url_slug, secret_identity, appearances, first_appearance, [year], publisher_id, alignment_id, alive_status_id, eye_color_id, hair_color_id, sex_id)
select hr.pageId, hr.Name, hr.UrlSlug, hr.Id,
TRY_CAST(replace(hr.Appearances, '.0', '') as int) as Appearances,
hr.FirstAppearance,
case
	when hr.Year1 is not null then TRY_CAST(replace(hr.Year1, '.0', '') as int)
	else TRY_CAST(replace(hr.Year2, '.0', '') as int)
end as [year],
p.id as publisher_id, al.id as alignments_id, [as].id as alive_status_id, 
ec.id as eye_colors_id, hc.id as hair_colors_id, s.id as sexes_id
from HeroesRaw as hr
join Publishers as p on p.description = hr.Publisher
left join Alignments as al on al.description = hr.Align
left join AliveStatus as [as] on [as].description = hr.Alive
left join EyeColors as ec on ec.description = hr.Eye
left join HairColors as hc on hc.description = hr.Hair
left join Sexes as s on s.description = hr.Sex
go

select * from
Heroes
go