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
-- Deep breath
go
create procedure SP_NAPRAVI_TABELU
@ime_tabele nchar(30),
@parametri nchar(4000)
as
begin
	declare @sql_string nchar(4000), @individualni_parametar nchar(4000);
	declare @start int = 0, @end int;
	set @sql_string = 'create table ' + upper(rtrim(ltrim(@ime_tabele))) + '(';
	set @sql_string = rtrim(@sql_string) + 'ID int primary key identity(1000, 1), ';
	while charindex('|', @parametri, @start + 1) > 0
	begin
		set @end = charindex('|', @parametri, @start + 1) - @start;
		set @individualni_parametar = substring(@parametri, @start, @end);
		set @sql_string = rtrim(@sql_string) + rtrim(ltrim(@individualni_parametar)) + ', ';
		set @start = charindex('|', @parametri, @start + @end) + 1;
	end;
	set @sql_string = substring(rtrim(@sql_string), 0, len(@sql_string)) + ')';
	print(@sql_string);
	exec sp_executesql @sql_string
end
go
create function FU_NAPRAVI_KOLONU (@ime_kolone nchar(30), @tip_atributa nchar(19), @notnull int = 1)
returns nchar(60)
as
begin 
	declare @sql_string nchar(60);
	set @sql_string = upper(rtrim(ltrim(@ime_kolone)) + ' ' + ltrim(rtrim(@tip_atributa)));
	if @notnull = 1
		set @sql_string = rtrim(@sql_string) + ' not null';
	set @sql_string = rtrim(@sql_string) + '|';
	return @sql_string;
end
go
create function FU_NAPRAVI_NCHAR_KOLONU (@ime_kolone nchar(30), @velicina int = 10, @notnull int = 1, @default nchar(20))
returns nchar(90)
as 
begin
	declare @sql_string nchar(90);
	set @sql_string = upper(rtrim(ltrim(@ime_kolone)) + ' nchar(' + cast(@velicina as nchar(4)) + ')');
	if @notnull = 1
		set @sql_string = rtrim(@sql_string) + ' not null';
	if @default is not null
		set @sql_string = rtrim(@sql_string) + ' default ''' + rtrim(@default) + '''';
	set @sql_string = rtrim(@sql_string) + '|';
	return @sql_string;
end
go
create function FU_NAPRAVI_INT_KOLONU (@ime_kolone nchar(30), @notnull int = 1, @default int)
returns nchar(60)
as 
begin
	declare @sql_string nchar(60);
	set @sql_string = upper(rtrim(ltrim(@ime_kolone)) + ' int');
	if @notnull = 1
		set @sql_string = rtrim(@sql_string) + ' not null';
	if @default is not null
		set @sql_string = rtrim(@sql_string) + ' default ' + rtrim(cast(@default as nchar(2)));
	set @sql_string = rtrim(@sql_string) + '|';
	return @sql_string
end
go
create function FU_NAPRAVI_DATE_KOLONU (@ime_kolone nchar(30), @notnull int = 1, @default_now int = 0)
returns nchar(70)
as 
begin
	declare @sql_string nchar(70);
	set @sql_string = upper(rtrim(ltrim(@ime_kolone)) + ' date');
	if @notnull = 1
		set @sql_string = rtrim(@sql_string) + ' not null';
	if @default_now = 1
		set @sql_string = rtrim(@sql_string) + ' default getdate()';
	set @sql_string = rtrim(@sql_string) + '|';
	return @sql_string;
end
go
create function FU_NAPRAVI_NUMERIC_KOLONU (@ime_kolone nchar(30), @precision int = 1, @scale int = 1, @notnull int = 1, @default numeric(10, 5))
returns nchar(100)
as begin
	declare @sql_string nchar(100);
	set @sql_string = upper(rtrim(ltrim(@ime_kolone)) + ' numeric(' + cast(@precision as nchar(2)) + ',' + cast(@scale as nchar(2)) + ')');
	if @notnull = 1
		set @sql_string = rtrim(@sql_string) + ' not null';
	if @default is not null
		set @sql_string = rtrim(@sql_string) + ' default ' + cast(@default as nchar(10));
	set @sql_string = rtrim(@sql_string) + '|';
	return @sql_string;
end;
-- Aaaand breathe out!
