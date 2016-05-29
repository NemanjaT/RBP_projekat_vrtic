begin
	declare @string nchar(600);
	set @string = 
		rtrim(dbo.FU_NAPRAVI_KOLONU('ime', 'nchar(30)', 0)) + 
		rtrim(dbo.FU_NAPRAVI_KOLONU('prezime', 'nchar(60)', 1));
	print @string
	exec dbo.SP_NAPRAVI_TABELU 'DECA', @string;
end

use [master]
go
begin
	drop DATABASE [VRTIC]
END

-- deleting backup...
use [master]
go
begin
drop login DB_KORISNIK
drop login DB_ADMIN
drop login DB_PRIV
drop user DB_KORISNIK
drop user DB_ADMIN
drop user DB_PRIV
end
use [VRTIC]
go
begin
drop login DB_KORISNIK
drop login DB_ADMIN
drop login DB_PRIV
drop user DB_KORISNIK
drop user DB_ADMIN
drop user DB_PRIV
end

-- delete trigger backup
begin
	drop trigger TRG_DECA
end




use [VRTIC]
go
merge dbo.TAB_DECA as target
using (select 'Danijela', 'Pribic', cast('03/02/2016' as date), 1000, '')
as source (IME, PREZIME, DATUM_RODJENJA, GRUPA_ID, DODATNE_INFORMACIJE)
on (target.IME = source.IME and target.PREZIME = source.PREZIME and target.DATUM_RODJENJA = source.DATUM_RODJENJA
	and target.GRUPA_ID = source.GRUPA_ID and target.DODATNE_INFORMACIJE = source.DODATNE_INFORMACIJE)
when matched then 
	update set STATUS = 1
when not matched then
	insert (IME, PREZIME, DATUM_RODJENJA, GRUPA_ID, DODATNE_INFORMACIJE)
	values ('Danijela', 'Pribic', cast('03/02/2016' as date), 1000, '');