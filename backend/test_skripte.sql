begin
	declare @string nchar(600);
	set @string = 
		rtrim(dbo.FU_NAPRAVI_KOLONU('ime', 'nchar(30)', 0)) + 
		rtrim(dbo.FU_NAPRAVI_KOLONU('prezime', 'nchar(60)', 1));
	print @string
	exec dbo.SP_NAPRAVI_TABELU 'DECA', @string;
end