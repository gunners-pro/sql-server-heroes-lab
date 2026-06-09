create database HeroesLab
go
use HeroesLab
go
-- page_id,name,urlslug,ID,ALIGN,EYE,HAIR,SEX,GSM,ALIVE,APPEARANCES,FIRST APPEARANCE,Year,publisher,YEAR
create table HeroesRaw (
	PageId nvarchar(255),
	[Name] nvarchar(255),
	UrlSlug nvarchar(255),
	Id nvarchar(255),
	Align nvarchar(255),
	Eye nvarchar(255),
	Hair nvarchar(255),
	Sex nvarchar(255),
	Gsm nvarchar(255),
	Alive nvarchar(255),
	Appearances nvarchar(255),
	FirstAppearance nvarchar(255),
	Year1 nvarchar(255),
	Publisher nvarchar(255),
	Year2 nvarchar(255)
)
go