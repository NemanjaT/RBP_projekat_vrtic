use [VRTIC]
go
begin
	truncate table TAB_STARATELJI_DECA;
	truncate table TAB_DECA;
	truncate table TAB_GRUPE;
	truncate table TAB_STARATELJI;
	truncate table TAB_FINANSIJSKE_GRUPE;
	truncate table TAB_INCIDENTI;
end
go
begin
	set identity_insert TAB_GRUPE on;
	insert into TAB_GRUPE (ID, IME_GRUPE, SPRAT, VASPITACI, CENA)
	values (1000, 'Cvetici', 2, 'Dragana Mitic, Snezana Savic', '3000.0'),
		   (1001, 'Autici', 1, 'Jagorka Stamonasivljevic Jovanovic, John Doe, Foo Bar', '3200.0');
	set identity_insert TAB_GRUPE off;

	set identity_insert TAB_DECA on;
	insert into TAB_DECA (ID, IME, PREZIME, DATUM_RODJENJA, GRUPA_ID, DODATNE_INFORMACIJE)
	values (1000, 'Kika', 'Simic', CAST('01/01/2010' as date), 1000, ''),
		   (1001, 'Milja', 'Trifunovic', CAST('12/31/2009' as date), 1000, 'Cerka Sinise Trifunovica'),
		   (1002, 'Snezana', 'Andjelkovic', CAST('05/08/2008' as date), 1000, 'Cerka Milosa Andjelkovica'),
		   (1003, 'Mina', 'Tozic', CAST('12/06/2011' as date), 1000, 'Cerka Nemanje Tozica'),
		   (1004, 'Brena', 'Lepa', CAST('05/04/2010' as date), 1000, ''),
		   (1005, 'Svetlana', 'Raznatovic', CAST('07/10/2009' as date), 1000, 'Stalno pominje gromove...'),
		   (1006, 'Nikola', 'Simic', CAST('09/12/2009' as date), 1001, ''),
		   (1007, 'Dragan', 'Nikolic', CAST('08/10/2010' as date), 1001, 'Buduci kralj'),
		   (1008, 'Nikola', 'Tesla', CAST('09/28/2011' as date), 1001, 'Sokantan decko...'),
		   (1009, 'Stevan', 'Sindjelic', CAST('03/02/2009' as date), 1001, ''),
		   (1010, 'Sasa', 'Matic', CAST('10/26/2008' as date), 1001, 'Slabiji vid');
	set identity_insert TAB_DECA off;

	set identity_insert TAB_FINANSIJSKE_GRUPE on;
	insert into TAB_FINANSIJSKE_GRUPE (ID, IME_GRUPE, FINANSIJSKI_OD, FINANSIJSKI_DO, DODATNE_INFORMACIJE)
	values (1000, 'Bez primanja', 0.0, 5000.0, ''),
		   (1001, 'Slabija primanja', 5000.01, 15000.0, ''),
		   (1002, 'Srednja primanja', 15000.01, 30000.0, ''),
		   (1003, 'Jaca primanja', 30000.01, 60000.0, ''),
		   (1004, 'Premium', 60000.01, 150000.0, ''),
		   (1005, 'Gold', 150000.01, 500000.0, '');
	set identity_insert TAB_FINANSIJSKE_GRUPE off;
	
	set identity_insert TAB_STARATELJI on;
	insert into TAB_STARATELJI (ID, IME, PREZIME, JMBG, U_RADNOM_ODNOSU, FINANSIJSKA_GRUPA_ID, DODATNE_INFORMACIJE, STARATELJ_ID)
	values (1000, 'Sinisa', 'Trifunovic', '123456789123', 1, 1005, '', null),
		   (1001, 'Milos', 'Andjelkovic', '123456789012', 1, 1004, '', null),
		   (1002, 'Nemanja', 'Tozic', '234567890123', 1, 1004, '', null),
		   (1003, 'Andjelka', 'Trifunovic', '345678901234', 99, null, '', 1000),
		   (1004, 'Ivana', 'Andjelkovic', '456789012345', 1, 1002, 'Dobio je kao rodjendanski poklon', 1001),
		   (1005, 'Igor', 'Nikolic', '57890123456', 99, null, '', null),
		   (1006, 'Svetozar', 'Sindjelic', 1, 1000, null, '', null);
	set identity_insert TAB_STARATELJI off;

	set identity_insert TAB_STARATELJI_DECA on;
	insert into TAB_STARATELJI_DECA (ID, DETE_ID, STARATELJ_ID, ODNOS)
	values (1000, 1001, 1000, 'Otac'),
		   (1001, 1001, 1003, 'Majka'),
		   (1002, 1002, 1001, 'Otac'),
		   (1003, 1002, 1004, 'Legalna Majka'),
		   (1004, 1003, 1002, 'Otac'),
		   (1005, 1007, 1005, 'Otac'),
		   (1006, 1010, 1005, 'Komsija'),
		   (1007, 1004, 1005, 'Ujak'),
		   (1008, 1005, 1006, 'Fan'),
		   (1009, 1008, 1006, 'Slusalac'),
		   (1010, 1009, 1006, 'Otac'),
		   (1011, 1000, 1004, 'Tetka');
	set identity_insert TAB_STARATELJI_DECA off;

	set identity_insert TAB_INCIDENTI on;
	insert into TAB_INCIDENTI (ID, DETE_ID, FINANSIJSKA_ODSTETA, PRISUTNI_VASPITAC, OPIS_INCIDENTA)
	values (1000, 1001, 30000.0, 'Veljko Domar', 'Gurnula klavir kroz prozor.'),
		   (1001, 1008, 15000.0, 'Stasa Kuvarica', 'Zapalio osigurac');
	set identity_insert TAB_INCIDENTI off;
end