select * from HeroesRaw
go

select distinct count(*) as qtd, align 
from HeroesRaw
group by align
order by align
go

select distinct publisher
from HeroesRaw
order by Publisher
go

select count(*) as qtd_null
from HeroesRaw
where Appearances is null
go

create table Alignments (
	id int identity(1,1) not null,
	description varchar(255) not null,
	constraint pk_alignment_id primary key clustered (id)
)
go

select * from Alignments
go

insert into Alignments (description)
select distinct align
from HeroesRaw
where align is not null
go

create table Publishers (
	id int identity(1,1) not null,
	description varchar(255) not null,
	constraint pk_publisher_id primary key clustered (id)
)
go

insert into Publishers (description)
select distinct Publisher
from HeroesRaw
where Publisher is not null
go

select * from Publishers
go

select distinct eye
from HeroesRaw
go

create table EyeColors (
	id int identity(1,1) not null,
	description varchar(255) not null,
	constraint pk_eye_color_id primary key clustered (id)
)
go

insert into EyeColors (description)
select distinct eye
from HeroesRaw
where eye is not null
go

select * from EyeColors
go

select distinct hair
from HeroesRaw
go

create table HairColors (
	id int identity(1,1) not null,
	description varchar(255) not null,
	constraint pk_hair_color_id primary key clustered (id)
)
go

insert into HairColors (description)
select distinct hair
from HeroesRaw
where hair is not null
go

select * from HairColors
go

select distinct sex
from HeroesRaw
go

create table Sexes (
	id int identity(1,1) not null,
	description varchar(255) not null,
	constraint pk_sex_id primary key clustered (id)
)
go

insert into Sexes (description)
select distinct sex
from HeroesRaw
where sex is not null
go

select * from Sexes
go

select distinct alive
from HeroesRaw
go

create table AliveStatus (
	id int identity(1,1) not null,
	description varchar(255) not null,
	constraint pk_alive_status_id primary key clustered (id)
)

insert into AliveStatus (description)
select distinct alive
from HeroesRaw
where alive is not null
go

select * from AliveStatus
go

create table Heroes (
	id int identity(1,1) not null,
	page_id int not null,
	[name] varchar(255) null,
	url_slug varchar(255) null,
	secret_identity varchar(100) null,
	appearances int null,
	first_appearance varchar(20) null,
	[year] int null,
	publisher_id int not null,
	alignment_id int null,
	eye_color_id int null,
	hair_color_id int null,
	sex_id int null,
	alive_status_id int null,
	constraint pk_hero_id primary key clustered (id),
	constraint fk_hero_publisher_id foreign key (publisher_id) references Publishers(id),
	constraint fk_hero_alignment_id foreign key (alignment_id) references Alignments(id),
	constraint fk_hero_eye_color_id foreign key (eye_color_id) references EyeColors(id),
	constraint fk_hero_hair_color_id foreign key (hair_color_id) references HairColors(id),
	constraint fk_hero_sex_id foreign key (sex_id) references Sexes(id),
	constraint fk_hero_alive_status_id foreign key (alive_status_id) references AliveStatus(id)
)
go

select * from Heroes
go