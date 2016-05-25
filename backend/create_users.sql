-- ### create_users.sql ###

use [master]
go
begin
	create login DB_ADMIN with password = 'lozinka';
	create login DB_KORISNIK with password = 'lozinka';
	alter login DB_ADMIN enable;
	alter login DB_KORISNIK enable;
end
go
use [VRTIC]
go
begin
	create user DB_ADMIN for login DB_ADMIN;
	create user DB_KORISNIK for login DB_KORISNIK;
	exec sp_addrolemember 'db_owner', 'DB_ADMIN';
	grant select on dbo.VW_DECA to DB_KORISNIK;
	grant select on dbo.VW_FINANSIJSKE_GRUPE to DB_KORISNIK;
	grant select on dbo.VW_GRUPE to DB_KORISNIK;
	grant select on dbo.VW_INCIDENTI to DB_KORISNIK;
	grant select on dbo.VW_OSTAVLJANJA_DECE to DB_KORISNIK;
	grant select on dbo.VW_PREUZIMANJA_DECE to DB_KORISNIK;
	grant select on dbo.VW_RACUNI to DB_KORISNIK;
	grant select on dbo.VW_STARATELJI to DB_KORISNIK;
	grant select on dbo.VW_STARATELJI_DECA to DB_KORISNIK;
	grant select on dbo.VW_UPLATE to DB_KORISNIK;
	grant execute on dbo.SP_NAPRAVI_TABELU to DB_KORISNIK;
	grant insert, update on dbo.TAB_DECA to DB_KORISNIK;
	grant insert, update on dbo.TAB_FINANSIJSKE_GRUPE to DB_KORISNIK;
	grant insert, update on dbo.TAB_GRUPE to DB_KORISNIK;
	grant insert, update on dbo.TAB_INCIDENTI to DB_KORISNIK;
	grant insert, update on dbo.TAB_OSTAVLJANJA_DECE to DB_KORISNIK;
	grant insert, update on dbo.TAB_PREUZIMANJA_DECE to DB_KORISNIK;
	grant insert, update on dbo.TAB_RACUNI to DB_KORISNIK;
	grant insert, update on dbo.TAB_STARATELJI to DB_KORISNIK;
	grant insert, update on dbo.TAB_STARATELJI_DECA to DB_KORISNIK;
	grant insert, update on dbo.TAB_UPLATE to DB_KORISNIK;
end
go
use [master]
go
begin
	create user DB_ADMIN for login DB_ADMIN;
	create user DB_KORISNIK for login DB_KORISNIK;
	exec sp_addrolemember 'db_owner', 'DB_ADMIN';
end
