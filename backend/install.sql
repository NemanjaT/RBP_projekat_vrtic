-- ### install.sql ###

use [master]
go
create database [VRTIC]
go
use [VRTIC]
go
begin
	-- initial stuff
	create table META_TABELE
	(
		ID int not null primary key identity (1000, 1),
		IME_TABELE nchar(30),
		AKRONIM nchar(4),
		DATUM_KREIRANJA date,
		DATUM_MODIFIKACIJE date
	);

	create table META_KOLONE
	(
		ID int not null primary key identity (1000, 1),
		META_TABELE_ID int,
		IME_KOLONE nchar(30),
		DATUM_KREIRANJA date,
		DATUM_MODIFIKACIJE date
	);
		
	alter table META_KOLONE
	add constraint FK_META_KOLONE_META_TABELE
	foreign key (META_TABELE_ID)
	references META_TABELE (ID);
end
go
create procedure SP_NAPRAVI_TABELU
@ime_tabele nchar(30),
@parametri nchar(600)
as
begin
	declare @sql_string nchar(1000) = '';
	declare @individualni nchar(1000)
	set @sql_string = concat('create table ', upper(@ime_tabele), '(');
	set @sql_string = concat(@sql_string, 'id int primary key (1000, 1),')
	select @sql_string;
	while len(@parametri) > 0
	begin
		-- izdvoji individualni parametar (kolonu)
		set @individualni = substring (@parametri, 0, patindex('%|%', @parametri))
		set @sql_string = concat(@sql_string, @individualni, ', ')
		-- izbaci obradjeni parametar iz liste
		set @parametri = substring (@parametri, len(@individualni + '|') + 1, len(@parametri))
	end
	set @sql_string = concat(substring (@sql_string, 0, len(@sql_string) - 2), ')')
	--execute @sql_string
end
go
create function FU_NAPRAVI_KOLONU (@ime_kolone nchar(30), @tip_atributa nchar(30), @notnull int = 1)
returns nchar
as
begin 
	declare @sql_string nchar(600) = '';
	set @sql_string = @ime_kolone + ' ' + @tip_atributa;
	if @notnull = 1
		set @sql_string = @sql_string + ' not null';
	return @sql_string;
end
