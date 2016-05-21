-- NE POKRECI OVE SKRIPTE
-- DO NOT RUN THESE SCRIPTS
-- laufen nicht diese Skripte
-- dili modagan niini nga mga sinulatan
-- no ejecute estas secuencias de comandos
-- nie uruchamiać te skrypty

begin
	declare @string nchar(600);
	set @string = 
		rtrim(dbo.FU_NAPRAVI_KOLONU('ime', 'nchar(30)', 0)) + 
		rtrim(dbo.FU_NAPRAVI_KOLONU('prezime', 'nchar(60)', 1));
	print @string
	exec dbo.SP_NAPRAVI_TABELU 'DECA', @string;
end
