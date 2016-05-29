-- ### create_users.sql ###

use [master]
go
begin
	create login DB_ADMIN with password = 'lozinka';
	create login DB_KORISNIK with password = 'lozinka';
	create login DB_PRIV with password = 'lozinka';
	alter login DB_ADMIN enable;
	alter login DB_KORISNIK enable;
	alter login DB_PRIV enable;
end
go
use [VRTIC]
go
begin
	create user DB_ADMIN for login DB_ADMIN;
	create user DB_KORISNIK for login DB_KORISNIK;
	create user DB_PRIV for login DB_PRIV;
	
	-- admin grantovi ...
	exec sp_addrolemember 'db_owner', 'DB_ADMIN';
	
	-- korisnik grantovi ...
	grant select on dbo.VW_DECA to DB_KORISNIK;
	grant select on dbo.VW_GRUPE to DB_KORISNIK;
	grant select on dbo.VW_INCIDENTI to DB_KORISNIK;
	grant select on dbo.VW_OSTAVLJANJA_DECE to DB_KORISNIK;
	grant select on dbo.VW_PREUZIMANJA_DECE to DB_KORISNIK;
	grant select on dbo.VW_STARATELJI to DB_KORISNIK;
	grant select on dbo.VW_STARATELJI_DECA to DB_KORISNIK;
	
	-- priv grantovi
	grant select on dbo.VW_DECA to DB_PRIV;
	grant select on dbo.VW_FINANSIJSKE_GRUPE to DB_PRIV;
	grant select on dbo.VW_GRUPE to DB_PRIV;
	grant select on dbo.VW_INCIDENTI to DB_PRIV;
	grant select on dbo.VW_OSTAVLJANJA_DECE to DB_PRIV;
	grant select on dbo.VW_PREUZIMANJA_DECE to DB_PRIV;
	grant select on dbo.VW_RACUNI to DB_PRIV;
	grant select on dbo.VW_STARATELJI to DB_PRIV;
	grant select on dbo.VW_STARATELJI_DECA to DB_PRIV;
	grant select on dbo.VW_UPLATE to DB_PRIV;

	grant execute on dbo.SP_NAPRAVI_TABELU to DB_PRIV;
	grant execute on dbo.SP_DODAJ_FK_CONSTRAINT to DB_PRIV;
	grant execute on dbo.SP_DODAJ_UK_CONSTRAINT to DB_PRIV;

	-- stari grantovi su sada zamenjeni sa stornim procedurama koje to rade...
	-- ostavljeni su update grant-ovi zato sto se recordi brisu tako sto se STATUS update-uje na '99'
	grant update on dbo.TAB_DECA to DB_PRIV;
	grant update on dbo.TAB_FINANSIJSKE_GRUPE to DB_PRIV;
	grant update on dbo.TAB_GRUPE to DB_PRIV;
	grant update on dbo.TAB_INCIDENTI to DB_PRIV;
	grant update on dbo.TAB_OSTAVLJANJA_DECE to DB_PRIV;
	grant update on dbo.TAB_PREUZIMANJA_DECE to DB_PRIV;
	grant update on dbo.TAB_RACUNI to DB_PRIV;
	grant update on dbo.TAB_STARATELJI to DB_PRIV;
	grant update on dbo.TAB_STARATELJI_DECA to DB_PRIV;
	grant update on dbo.TAB_UPLATE to DB_PRIV;

	grant execute on dbo.SP_DODAJ_DETE to DB_PRIV;
	grant execute on dbo.SP_DODAJ_FINANSIJSKU_GRUPU to DB_PRIV;
	grant execute on dbo.SP_DODAJ_GRUPU to DB_PRIV;
	grant execute on dbo.SP_DODAJ_INCIDENT to DB_PRIV;
	grant execute on dbo.SP_DODAJ_OSTAVLJANJE_DETETA to DB_PRIV;
	grant execute on dbo.SP_DODAJ_PREUZIMANJE_DETETA to DB_PRIV;
	grant execute on dbo.SP_DODAJ_RACUN to DB_PRIV;
	grant execute on dbo.SP_DODAJ_STARATELJ_DETETA to DB_PRIV;
	grant execute on dbo.SP_DODAJ_STARATELJA to DB_PRIV;
	grant execute on dbo.SP_DODAJ_UPLATU to DB_PRIV;
end
go
use [master]
go
begin
	create user DB_ADMIN for login DB_ADMIN;
	create user DB_KORISNIK for login DB_KORISNIK;
	create user DB_PRIV for login DB_PRIV;
	exec sp_addrolemember 'db_owner', 'DB_ADMIN';
end
