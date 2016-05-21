-- ### create_tables.sql ###

begin
	-- TAB_DECA
	declare @definicija_tabele nchar(4000);
	set @definicija_tabele = 
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime', 15, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('prezime', 20, 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_rodjenja', 1, 0) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_dodavanja', 0, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_deca', 
							   @parametri  = @definicija_tabele;

	-- TAB_RODITELJI
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime', 15, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('prezime', 20, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('jmbg', 12, 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('u_radnom_odnosu', 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_dodavanja', 0, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '');
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_staratelji',
							   @parametri  = @definicija_tabele;

	-- TAB_STARATELJI_DECA
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('dete_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('staratelj_id', 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('odnos', 15, 0, null)
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 'tab_staratelji_deca',
							   @parametri  = @definicija_tabele;
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_staratelji_deca',
									@ime_glavne_kolone = 'dete_id',
									@ime_target_tabele = 'tab_deca',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_staratelji_deca',
									@ime_glavne_kolone = 'staratelj_id',
									@ime_target_tabele = 'tab_staratelji',
									@ime_target_kolone = 'id';
end