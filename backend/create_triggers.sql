-- ### create_triggers.sql ###

use [VRTIC]
go
create trigger TRG_DECA
on dbo.TAB_DECA
after insert
as
begin
	set nocount on;
	update dbo.TAB_DECA
	set DATUM_DODAVANJA = i.DATUM_DODAVANJA
	from dbo.TAB_DECA td
	join inserted i on i.ID = td.ID
	where td.ID = i.ID
end
go
create trigger TRG_STARATELJI
on dbo.TAB_STARATELJI
after insert
as
begin
	set nocount on;
	update dbo.TAB_STARATELJI
	set DATUM_DODAVANJA = i.DATUM_DODAVANJA
	from dbo.TAB_STARATELJI st
	join inserted i on i.ID = st.ID
	where st.ID = i.ID
end
go
create trigger TRG_INCIDENTI
on dbo.TAB_INCIDENTI
after insert
as
begin
	set nocount on;
	declare @datum date;
	select @datum = max(DATUM) from inserted;
	if @datum is null
	begin
		update dbo.TAB_INCIDENTI
		set DATUM = getdate()
		from dbo.TAB_INCIDENTI inc
		join inserted i on i.ID = inc.ID
		where i.ID = inc.ID;
	end;
end
go
create trigger TRG_OSTAVLJANJA_DECE
on dbo.TAB_OSTAVLJANJA_DECE
after insert
as
begin
	set nocount on;
	declare @datum date;
	select @datum = max(VREME_OSTAVLJANJA) from inserted;
	if @datum is null
	begin
		update dbo.TAB_OSTAVLJANJA_DECE
		set VREME_OSTAVLJANJA = getdate()
		from dbo.TAB_OSTAVLJANJA_DECE inc
		join inserted i on i.ID = inc.ID
		where i.ID = inc.ID;
	end;
end
go
create trigger TRG_PREUZIMANJA_DECE
on dbo.TAB_PREUZIMANJA_DECE
after insert
as
begin
set nocount on;
	declare @datum date;
	select @datum = max(VREME_PREUZIMANJA) from inserted;
	if @datum is null
	begin
		update dbo.TAB_PREUZIMANJA_DECE
		set VREME_PREUZIMANJA = getdate()
		from dbo.TAB_PREUZIMANJA_DECE inc
		join inserted i on i.ID = inc.ID
		where i.ID = inc.ID;
	end;
end
go
create trigger TRG_UPLATE
on dbo.TAB_UPLATE
after insert
as
begin
set nocount on;
	-- ubacivanje vremena_uplate ako ne postoji
	declare @datum date;
	select @datum = max(VREME_UPLATE) from inserted;
	if @datum is null
	begin
		update dbo.TAB_UPLATE
		set VREME_UPLATE = getdate()
		from dbo.TAB_UPLATE inc
		join inserted i on i.ID = inc.ID
		where i.ID = inc.ID;
	end;

	-- settovanje otplacenosti za racun ukoliko je suma dovoljna
	--declare @ukupno_uplaceno numeric(12,2);
	declare @trenutni_red int = 0, @ukupno_redova int;
	declare @uplata numeric(10,2), @racun_id int, @ukupni_racun numeric(10,2);
	declare @temp_tabela table 
		(RAW_ID int not null primary key identity (1,1), UPLATA numeric(10,2), RACUN_ID int);
	insert into @temp_tabela (UPLATA, RACUN_ID) 
		select sum(UPLATA), RACUN_ID 
		from TAB_UPLATE
		where year(VREME_UPLATE) = year(sysdatetime())
		and month(VREME_UPLATE) = month(sysdatetime())
		group by RACUN_ID;
	set @ukupno_redova = @@ROWCOUNT;
	while @trenutni_red < @ukupno_redova
	begin
		set @trenutni_red = @trenutni_red + 1;
		
		select @uplata = UPLATA, @racun_id = RACUN_ID
		from @temp_tabela
		where RAW_ID = @trenutni_red;
		
		select @ukupni_racun = UKUPNI_RACUN
		from TAB_RACUNI
		where ID = @racun_id
		and RACUN_OTPLACEN <> 1;

		if @uplata >= @ukupni_racun
		begin
			update TAB_RACUNI
			set RACUN_OTPLACEN = 1
			where ID = @racun_id;
		end
	end
end
