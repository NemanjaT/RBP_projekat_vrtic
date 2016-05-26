-- ## create_merge_procedures.sql ##

use [VRTIC]
go
create procedure SP_DODAJ_DETE
@ime nchar(15),
@prezime nchar(20),
@datum_rodjenja date,
@grupa_id int,
@dodatne_informacije nchar(200)
as
begin
	merge dbo.TAB_DECA as target
	using (select @ime, @prezime, @datum_rodjenja, @grupa_id, @dodatne_informacije)
	as source (IME, PREZIME, DATUM_RODJENJA, GRUPA_ID, DODATNE_INFORMACIJE)
	on (target.IME = source.IME and target.PREZIME = source.PREZIME and target.DATUM_RODJENJA = source.DATUM_RODJENJA
		and target.GRUPA_ID = source.GRUPA_ID and target.DODATNE_INFORMACIJE = source.DODATNE_INFORMACIJE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME, PREZIME, DATUM_RODJENJA, GRUPA_ID, DODATNE_INFORMACIJE, STATUS)
		values (@ime, @prezime, @datum_rodjenja, @grupa_id, @dodatne_informacije, 1);
end
go
create procedure SP_DODAJ_STARATELJA
@ime nchar(15),
@prezime nchar(20),
@jmbg nchar(12),
@u_radnom_odnosu int,
@finansijska_grupa_id int,
@dodatne_informacije date,
@staratelj_id int
as
begin
	merge dbo.TAB_STARATELJI as t
	using (select @ime, @prezime, @jmbg, @u_radnom_odnosu, @finansijska_grupa_id, @dodatne_informacije, @staratelj_id)
	as s (IME, PREZIME, JMBG, U_RADNOM_ODNOSU, FINANSIJSKA_GRUPA_ID, DODATNE_INFORMACIJE, STARATELJ_ID)
	on (t.IME = s.IME and t.PREZIME = s.PREZIME and t.JMBG = s.JMBG and t.U_RADNOM_ODNOSU = s.U_RADNOM_ODNOSU and
		t.FINANSIJSKA_GRUPA_ID = s.FINANSIJSKA_GRUPA_ID and t.DODATNE_INFORMACIJE = s.DODATNE_INFORMACIJE and
		t.STARATELJ_ID = s.STARATELJ_ID)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME, PREZIME, JMBG, U_RADNOM_ODNOSU, FINANSIJSKA_GRUPA_ID, DODATNE_INFORMACIJE, STARATELJ_ID, STATUS)
		values (@ime, @prezime, @jmbg, @u_radnom_odnosu, @finansijska_grupa_id, @dodatne_informacije, @staratelj_id, 1);
end
go
create procedure SP_DODAJ_STARATELJ_DETETA
@dete_id int,
@staratelj_id int,
@odnos nchar(15)
as
begin
	merge dbo.TAB_STARATELJI_DECA as t
	using (select @dete_id, @staratelj_id, @odnos) as s (DETE_ID, STARATELJ_ID, ODNOS)
	on (t.DETE_ID = s.DETE_ID and t.STARATELJ_ID = s.STARATELJ_ID and t.ODNOS = s.ODNOS)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (DETE_ID, STARATELJ_ID, ODNOS, STATUS) values (@dete_id, @staratelj_id, @odnos, 1);
end
go
create procedure SP_DODAJ_GRUPU
@ime_grupe nchar(20),
@sprat int,
@vaspitaci nchar(500),
@cena nchar(7)
as
begin
	merge dbo.TAB_GRUPE as t
	using (select @ime_grupe, @sprat, @vaspitaci, @cena) as s (IME_GRUPE, SPRAT, VASPITACI, CENA)
	on (t.IME_GRUPE = s.IME_GRUPE and t.SPRAT = s.SPRAT and t.VASPITACI = s.VASPITACI and t.CENA = s.CENA)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME_GRUPE, SPRAT, VASPITACI, CENA, STATUS) values (@ime_grupe, @sprat, @vaspitaci, @cena, 1);
end
go
create procedure SP_DODAJ_FINANSIJSKU_GRUPU
@ime_grupe nchar(20),
@finansijski_od numeric(7,2),
@finansijski_do numeric(7,2),
@dodatne_informacije nchar(200)
as
begin
	merge dbo.TAB_FINANSIJSKE_GRUPE as t
	using (select @ime_grupe, @finansijski_od, @finansijski_do, @dodatne_informacije)
	as s (IME_GRUPE, FINANSIJSKI_OD, FINANSIJSKI_DO, DODATNE_INFORMACIJE)
	on (t.IME_GRUPE = s.IME_GRUPE and t.FINANSIJSKI_OD = s.FINANSIJSKI_OD and t.FINANSIJSKI_DO = s.FINANSIJSKI_DO
		and t.DODATNE_INFORMACIJE = s.DODATNE_INFORMACIJE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME_GRUPE, FINANSIJSKI_OD, FINANSIJSKI_DO, DODATNE_INFORMACIJE, STATUS)
		values (@ime_grupe, @finansijski_od, @finansijski_do, @dodatne_informacije, 1);
end
go
create procedure SP_DODAJ_INCIDENT
@dete_id int,
@datum date,
@finansijska_odsteta numeric(7,2),
@prisutni_vaspitac nchar(35),
@opis_incidenta nchar(1000)
as
begin
	merge dbo.TAB_INCIDENTI as t
	using (select @dete_id, @datum, @finansijska_odsteta, @prisutni_vaspitac, @opis_incidenta)
	as s (DETE_ID, DATUM, FINANSIJSKA_ODSTETA, PRISUTNI_VASPITAC, OPIS_INCIDENTA)
	on (t.DETE_ID = s.DETE_ID and t.DATUM = s.DATUM and t.FINANSIJSKA_ODSTETA = s.FINANSIJSKA_ODSTETA and
		t.PRISUTNI_VASPITAC = s.PRISUTNI_VASPITAC and t.OPIS_INCIDENTA = s.OPIS_INCIDENTA)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (DETE_ID, DATUM, FINANSIJSKA_ODSTETA, PRISUTNI_VASPITAC, OPIS_INCIDENTA, STATUS)
		values (@dete_id, @datum, @finansijska_odsteta, @prisutni_vaspitac, @opis_incidenta, 1);
end
go
create procedure SP_DODAJ_OSTAVLJANJE_DETETA
@staratelj_id int,
@dete_id int,
@vreme_ostavljanja datetime,
@dodatne_informacije nchar(200)
as
begin
	if @vreme_ostavljanja is null
		set @vreme_ostavljanja = getdate();

	merge dbo.TAB_OSTAVLJANJA_DECE as t
	using (select @staratelj_id, @dete_id, @vreme_ostavljanja, @dodatne_informacije)
	as s (STARATELJ_ID, DETE_ID, VREME_OSTAVLJANJA, DODATNE_INFORMACIJE)
	on (t.STARATELJ_ID = s.STARATELJ_ID and t.DETE_ID = s.DETE_ID and t.VREME_OSTAVLJANJA = s.VREME_OSTAVLJANJA
		and t.DODATNE_INFORMACIJE = s.DODATNE_INFORMACIJE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (STARATELJ_ID, DETE_ID, VREME_OSTAVLJANJA, DODATNE_INFORMACIJE, STATUS)
		values (@staratelj_id, @dete_id, @vreme_ostavljanja, @dodatne_informacije, 1);
end
go
create procedure SP_DODAJ_PREUZIMANJE_DETETA
@staratelj_id int,
@dete_id int,
@vreme_preuzimanja datetime,
@dodatne_informacije nchar(200)
as
begin
	if @vreme_preuzimanja is null
		set @vreme_preuzimanja = getdate();

	merge dbo.TAB_PREUZIMANJA_DECE as t
	using (select @staratelj_id, @dete_id, @vreme_preuzimanja, @dodatne_informacije)
	as s (STARATELJ_ID, DETE_ID, VREME_OSTAVLJANJA, DODATNE_INFORMACIJE)
	on (t.STARATELJ_ID = s.STARATELJ_ID and t.DETE_ID = s.DETE_ID and t.VREME_PREUZIMANJA = s.VREME_OSTAVLJANJA
		and t.DODATNE_INFORMACIJE = s.DODATNE_INFORMACIJE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (STARATELJ_ID, DETE_ID, VREME_PREUZIMANJA, DODATNE_INFORMACIJE, STATUS)
		values (@staratelj_id, @dete_id, @vreme_preuzimanja, @dodatne_informacije, 1);
end
go
create procedure SP_DODAJ_RACUN
@ukupni_racun numeric(7,2),
@staratelj_id int,
@datum_otplate date,
@racun_otplacen int,
@dodatne_informacije nchar(200)
as
begin
	merge dbo.TAB_RACUNI as t
	using (select @ukupni_racun, @staratelj_id, @datum_otplate, @racun_otplacen, @dodatne_informacije)
	as s (UKUPNI_RACUN, STARATELJ_ID, DATUM_OTPLATE, RACUN_OTPLACEN, DODATNE_INFORMACIJE)
	on (t.UKUPNI_RACUN = s.UKUPNI_RACUN and t.STARATELJ_ID = s.STARATELJ_ID and t.DATUM_OTPLATE = s.DATUM_OTPLATE
		and t.RACUN_OTPLACEN = s.RACUN_OTPLACEN and t.DODATNE_INFORMACIJE = s.DODATNE_INFORMACIJE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (UKUPNI_RACUN, STARATELJ_ID, DATUM_OTPLATE, RACUN_OTPLACEN, DODATNE_INFORMACIJE, STATUS)
		values (@ukupni_racun, @staratelj_id, @datum_otplate, @racun_otplacen, @dodatne_informacije, 1);
end
go
create procedure SP_DODAJ_UPLATU
@racun_id int,
@uplata nchar(7),
@vreme_uplate datetime,
@poruka nchar(200)
as
begin
	merge dbo.TAB_UPLATE as t
	using (select @racun_id, @uplata, @vreme_uplate, @poruka) as s (RACUN_ID, UPLATA, VREME_UPLATE, PORUKA)
	on (t.RACUN_ID = s.RACUN_ID and t.UPLATA = s.UPLATA and t.VREME_UPLATE = s.VREME_UPLATE and t.PORUKA = s.PORUKA)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (RACUN_ID, UPLATA, VREME_UPLATE, PORUKA) values (@racun_id, @uplata, @vreme_uplate, @poruka);
end