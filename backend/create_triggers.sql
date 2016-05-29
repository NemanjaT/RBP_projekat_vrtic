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
end
