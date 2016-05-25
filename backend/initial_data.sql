use [VRTIC]
go
begin
	truncate table TAB_GRUPE;
	truncate table TAB_DECA;
end
begin
	insert into TAB_GRUPE (IME_GRUPE, SPRAT, VASPITACI, CENA)
	values ('Cvetici', 2, 'Dragana Mitic, Snezana Savic', 3000.0);
	insert into TAB_DECA (IME, PREZIME, DATUM_RODJENJA, GRUPA_ID, DODATNE_INFORMACIJE)
	values ('Nikola', 'Simic', CAST('01/01/2010' as date), 1000, ''),
		   ('Milja', 'Trajkovic', CAST('12/31/2009' as date), 1000, '');
end