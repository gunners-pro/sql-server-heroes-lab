use HeroesLab
go

create table HeroesAuditLog (
	log_id int identity(1,1) not null,
	hero_id int not null,
	action varchar(20) not null,
	old_name varchar(255) null,
	old_appearances int null,
	old_alignment_id int null,
	change_at datetime2 not null constraint df_change_at_date default sysdatetime(),
	changed_by varchar(100) not null constraint df_change_by_user default system_user,
	constraint pk_heroes_audit_log_id primary key clustered (log_id)
)
go

create or alter trigger trg_heroes_audit
on Heroes
after update, delete
as
begin
	set nocount on
	insert into HeroesAuditLog (hero_id, action, old_name, old_appearances, old_alignment_id)
	select id, 'DELETE', name, appearances, alignment_id
	from deleted
	where not exists (select 1 from inserted)

	insert into HeroesAuditLog (hero_id, action, old_name, old_appearances, old_alignment_id)
	select id, 'UPDATE', name, appearances, alignment_id
	from deleted
	where exists (select 1 from inserted)
end
go

SELECT * FROM HeroesAuditLog
go

update heroes
set appearances = 9999
where name = 'Teste'
go

select * from heroes
go

create or alter trigger trg_prevent_delete_iconic
on Heroes
instead of delete
as
begin
	set nocount on
	
	if exists (select 1 from deleted d join vw_iconic_heroes v on v.id = d.id)
	begin		
		raiserror('Heroi iconico não pode ser deletado', 16, 1);
	end
	else
	begin
		delete from Heroes
		where id in(select id from deleted)
	end
end
go

delete from heroes where name = 'Teste'
go
delete from heroes where name = 'Spider-Man (Peter Parker)'
go