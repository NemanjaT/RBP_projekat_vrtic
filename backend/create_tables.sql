-- ### create_tables.sql ###

use [VRTIC]
go
begin
	declare @definicija_tabele nchar(4000);
	
	-- TAB_GRUPE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime_grupe', 20, 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('sprat', 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('vaspitaci', 500, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('cena', 7, 2, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_grupe',
							   @parametri  = @definicija_tabele;


	-- TAB_FINANSIJSKE_GRUPE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime_grupe', 20, 1, null) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('finansijski_od', 10, 2, 1, null) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('finansijski_do', 10, 2, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_finansijske_grupe',
							   @parametri  = @definicija_tabele;


	-- TAB_DECA
	set @definicija_tabele = 
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime', 15, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('prezime', 20, 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_rodjenja', 1, 0) +
		dbo.FU_NAPRAVI_INT_KOLONU('grupa_id', 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_dodavanja', 0, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_deca', 
                               @parametri  = @definicija_tabele;

	-- TAB_STARATELJI
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime', 15, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('prezime', 20, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('jmbg', 12, 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('u_radnom_odnosu', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('finansijska_grupa_id', 0, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_dodavanja', 0, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('staratelj_id', 0, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_staratelji',
                               @parametri  = @definicija_tabele;

	-- TAB_STARATELJI_DECA
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('dete_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('staratelj_id', 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('odnos', 15, 0, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1)
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_staratelji_deca',
                               @parametri  = @definicija_tabele;

	-- TAB_RACUNI
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('ukupni_racun', 10, 2, 1, 0) +
		dbo.FU_NAPRAVI_INT_KOLONU('staratelj_id', 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_otplate', 1, 1) +
		dbo.FU_NAPRAVI_INT_KOLONU('racun_otplacen', 0, 99) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_racuni',
							   @parametri  = @definicija_tabele;

	-- TAB_UPLATE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('racun_id', 1, null) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('uplata', 10, 2, 1, null) +
		dbo.FU_NAPRAVI_DATETIME_KOLONU('vreme_uplate', 1, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('poruka', 200, 0, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_uplate',
							   @parametri  = @definicija_tabele;


	-- TAB_PREUZIMANJA_DECE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('staratelj_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('dete_id', 1, null) +
		dbo.FU_NAPRAVI_DATETIME_KOLONU('vreme_preuzimanja', 1, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_preuzimanja_dece',
							   @parametri  = @definicija_tabele;


	-- TAB_OSTAVLJANJA_DECE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('staratelj_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('dete_id', 1, null) +
		dbo.FU_NAPRAVI_DATETIME_KOLONU('vreme_ostavljanja', 1, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_ostavljanja_dece',
							   @parametri  = @definicija_tabele;


	-- TAB_INCIDENTI
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('dete_id', 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum', 1, 1) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('finansijska_odsteta', 10, 2, 0, 0) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('prisutni_vaspitac', 35, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('opis_incidenta', 1000, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_incidenti',
							   @parametri  = @definicija_tabele;
end
