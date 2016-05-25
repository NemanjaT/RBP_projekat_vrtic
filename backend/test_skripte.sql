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
drop user DB_KORISNIK
drop user DB_ADMIN
end
use [VRTIC]
go
begin
drop login DB_KORISNIK
drop login DB_ADMIN
drop user DB_KORISNIK
drop user DB_ADMIN
end

-- delete trigger backup
begin
	drop trigger TRG_DECA
end