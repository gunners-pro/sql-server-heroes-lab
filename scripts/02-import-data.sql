use HeroesLab
go
bulk insert HeroesRaw
from 'C:\Github\sql-server-heroes-lab\data\heroes.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	firstrow = 2,
	rowterminator = '0x0a'
)
go