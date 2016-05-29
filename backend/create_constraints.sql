-- ### create_constraints.sql ###

use [VRTIC]
go
begin
	-- TAB_DECA
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_deca',
									@ime_glavne_kolone = 'grupa_id',
									@ime_target_tabele = 'tab_grupe',
									@ime_target_kolone = 'id';

	-- TAB_STARATELJI
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_staratelji',
									@ime_glavne_kolone = 'staratelj_id',
									@ime_target_tabele = 'tab_staratelji',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_staratelji',
									@ime_glavne_kolone = 'finansijska_grupa_id',
									@ime_target_tabele = 'tab_finansijske_grupe',
									@ime_target_kolone = 'id';

	-- TAB_STARATELJI_DECA
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_staratelji_deca',
                                    @ime_glavne_kolone = 'dete_id',
                                    @ime_target_tabele = 'tab_deca',
                                    @ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_staratelji_deca',
                                    @ime_glavne_kolone = 'staratelj_id',
									@ime_target_tabele = 'tab_staratelji',
									@ime_target_kolone = 'id';

	-- TAB_RACUNI
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_racuni',
									@ime_glavne_kolone = 'staratelj_id',
									@ime_target_tabele = 'tab_staratelji',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 'tab_racuni',
									@imena_kolona = 'staratelj_id, datum_otplate',
									@sufiks       = 'placanja';

	-- TAB_UPLATE
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_uplate',
									@ime_glavne_kolone = 'racun_id',
									@ime_target_tabele = 'tab_racuni',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 'tab_uplate',
									@imena_kolona = 'uplata, vreme_uplate, poruka',
									@sufiks       = 'uplata';

	-- TAB_PREUZIMANJA_DECE
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_preuzimanja_dece',
									@ime_glavne_kolone = 'staratelj_id',
									@ime_target_tabele = 'tab_staratelji',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_preuzimanja_dece',
									@ime_glavne_kolone = 'dete_id',
									@ime_target_tabele = 'tab_deca',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 'tab_preuzimanja_dece',
									@imena_kolona = 'staratelj_id, dete_id, vreme_preuzimanja',
									@sufiks       = 'rod_dete';

	-- TAB_OSTAVLJANJA_DECE
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_ostavljanja_dece',
									@ime_glavne_kolone = 'staratelj_id',
									@ime_target_tabele = 'tab_staratelji',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_ostavljanja_dece',
									@ime_glavne_kolone = 'dete_id',
									@ime_target_tabele = 'tab_deca',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 'tab_ostavljanja_dece',
									@imena_kolona = 'staratelj_id, dete_id, vreme_ostavljanja',
									@sufiks       = 'rod_dete';

	-- TAB_INCIDENTI
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'tab_incidenti',
									@ime_glavne_kolone = 'dete_id',
									@ime_target_tabele = 'tab_deca',
									@ime_target_kolone = 'id';
end