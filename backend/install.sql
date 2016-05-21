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
@parametri nchar(1000)
as
begin
	declare @sql_string nchar(1000);
	declare @individualni nchar(1000);
	declare @start int = 0, @end int;
	declare @output table (splitdata nchar(10));
	set @sql_string = 'create table ' + upper(rtrim(ltrim(@ime_tabele))) + ' (';
	set @sql_string = rtrim(@sql_string) + 'ID int primary key identity(1000, 1), ';
	while charindex('|', @parametri, @start + 1) > 0
	begin
		set @end = charindex('|', @parametri, @start + 1) - @start;
		set @individualni = substring(@parametri, @start, @end);
		set @sql_string = rtrim(@sql_string) + rtrim(ltrim(@individualni)) + ', ';
		set @start = charindex('|', @parametri, @start + @end) + 1;
	end;
	set @sql_string = substring(rtrim(@sql_string), 0, len(@sql_string)) + ')';
	print @sql_string
	exec sp_executesql @sql_string
end
go
create function FU_NAPRAVI_KOLONU (@ime_kolone nchar(30), @tip_atributa nchar(30), @notnull int = 1)
returns nchar(70)
as
begin 
	declare @sql_string nchar(600);
	set @sql_string = upper(rtrim(ltrim(@ime_kolone)) + ' ' + ltrim(rtrim(@tip_atributa)));
	if @notnull = 1
		set @sql_string = rtrim(@sql_string) + ' not null';
	set @sql_string = rtrim(@sql_string) + '|';
	return @sql_string;
end
-- Aaaand breathe out!
