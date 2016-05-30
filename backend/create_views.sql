-- ## create_views.sql ##

use [VRTIC]
go
create view VW_DECA
as
select dc.ID, dc.IME, dc.PREZIME, dc.DATUM_RODJENJA, gr.IME_GRUPE, dc.DATUM_DODAVANJA
from TAB_DECA dc
join TAB_GRUPE gr on dc.GRUPA_ID = gr.ID and gr.STATUS <> 99
where dc.STATUS <> 99;
go
create view VW_FINANSIJSKE_GRUPE
as
select *
from TAB_FINANSIJSKE_GRUPE
where STATUS <> 99;
go
create view VW_GRUPE
as
select *
from TAB_GRUPE
where STATUS <> 99;
go
create view VW_INCIDENTI
as
select inc.ID, dc.IME as IME_DETETA, dc.PREZIME as PREZIME_DETETA, inc.FINANSIJSKA_ODSTETA, 
	inc.PRISUTNI_VASPITAC, inc.OPIS_INCIDENTA
from TAB_INCIDENTI inc
join TAB_DECA dc on inc.DETE_ID = dc.ID and dc.STATUS <> 99
where inc.STATUS <> 99;
go
create view VW_OSTAVLJANJA_DECE
as
select od.ID, st.IME as IME_STARATELJA, st.PREZIME as PREZIME_STARATELJA, dc.IME as IME_DETETA, 
	dc.PREZIME as PREZIME_DETETA, od.VREME_OSTAVLJANJA, od.DODATNE_INFORMACIJE
from TAB_OSTAVLJANJA_DECE od
join TAB_STARATELJI st on od.STARATELJ_ID = st.ID and st.STATUS <> 99
join TAB_DECA dc on od.DETE_ID = dc.ID and dc.STATUS <> 99
where od.STATUS <> 99
go
create view VW_PREUZIMANJA_DECE
as
select pd.ID, st.IME as IME_STARATELJA, st.PREZIME as PREZIME_STARATELJA, dc.IME as IME_DETETA, 
	dc.PREZIME as PREZIME_DETETA, pd.VREME_PREUZIMANJA, pd.DODATNE_INFORMACIJE
from TAB_PREUZIMANJA_DECE pd
join TAB_STARATELJI st on pd.STARATELJ_ID = st.ID and st.STATUS <> 99
join TAB_DECA dc on pd.DETE_ID = dc.ID and dc.STATUS <> 99
where pd.STATUS <> 99
go
create view VW_RACUNI
as
select r.ID, r.UKUPNI_RACUN, st.IME as IME_STARATELJA, st.PREZIME as PREZIME_STARATELJA,
	r.DATUM_OTPLATE, r.RACUN_OTPLACEN, r.DODATNE_INFORMACIJE
from TAB_RACUNI r
join TAB_STARATELJI st on r.STARATELJ_ID = st.ID and st.STATUS <> 99
where r.STATUS <> 99
go
create view VW_STARATELJI
as
select st.ID, st.IME, st.PREZIME, st.JMBG, st.U_RADNOM_ODNOSU, fg.IME_GRUPE, st.DATUM_DODAVANJA,
	st.DODATNE_INFORMACIJE, st.STARATELJ_ID as GLAVNI_STARATELJ
from TAB_STARATELJI st
join TAB_FINANSIJSKE_GRUPE fg on st.FINANSIJSKA_GRUPA_ID = fg.ID and fg.STATUS <> 99
where st.STATUS <> 99
go
create view VW_STARATELJI_DECA
as
select st.ID as ID_STARATELJA, st.IME as IME_STARATELJA, st.PREZIME as PREZIME_STARATELJA
	, sd.ID, sd.ODNOS, dc.ID as ID_DETETA, dc.IME as IME_DETETA, dc.PREZIME as PREZIME_DETETA
from TAB_STARATELJI_DECA sd
join TAB_DECA dc on sd.DETE_ID = dc.ID and dc.STATUS <> 99
join TAB_STARATELJI st on sd.STARATELJ_ID = st.ID and st.STATUS <> 99
where sd.STATUS <> 99
go
create view VW_UPLATE
as
select up.ID, up.RACUN_ID, r.UKUPNI_RACUN, up.UPLATA, up.VREME_UPLATE, up.PORUKA
from TAB_UPLATE up
join TAB_RACUNI r on up.RACUN_ID = r.ID and r.STATUS <> 99
where up.STATUS <> 99;
