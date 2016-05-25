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