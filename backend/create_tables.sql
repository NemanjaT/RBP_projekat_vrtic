-- ### create_tables.sql ###

begin
	drop table tab_deca;

	declare @definicija_tabele nchar(4000);
	set @definicija_tabele = 
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime', 15, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('prezime', 20, 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_rodjenja', 1, 0) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_dodavanja', 0, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 200, 0, '');
	exec dbo.SP_NAPRAVI_TABELU 'tab_deca', @definicija_tabele;
end