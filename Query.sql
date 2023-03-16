use Ogr�d_Zoologiczny;


select distinct Zwierze.Id_Zwierz�cia, Zwierze.Imi� FROM Dieta_Zwierz�cia
	INNER JOIN Zwierze ON Zwierze.Id_Zwierz�cia=Dieta_Zwierz�cia.Id_Zwierz�cia
	WHERE Dieta_Zwierz�cia.Kaloryczno�� > 2000;
	
select Choroba_Zwierz�cia.Id_Zwierz�cia, Choroba.Nazwa FROM Choroba_Zwierz�cia
	INNER JOIN Choroba ON Choroba.Id_Choroby=Choroba_Zwierz�cia.Id_Choroby
	WHERE Choroba.Zaka�liwos�='Bardzo zaka�liwa';

select Imi�, Nazwisko from Osoba
	where Id_Osoby in (select id_osoby from Pracownik_ZOO
							where Specjalizacja='Obs�uga finansowa');

select Zwierze.Id_Zwierz�cia, Zwierze.Imi� FROM Zwierze
	where Id_Zwierz�cia in (select Id_Zwierz�cia from Dieta_Zwierz�cia
								where Rodzaj='Z witaminami');

select Dieta_Zwierz�cia.Kaloryczno��, Dieta_Zwierz�cia.Id_Zwierz�cia
from Dieta_Zwierz�cia
where Dieta_Zwierz�cia.Rodzaj='Z witaminami' or Dieta_Zwierz�cia.Rodzaj='Hipoalergiczna'
order by Dieta_Zwierz�cia.Kaloryczno�� DESC;

select min(Koszt) as Najmniejszy_Koszt, max(Koszt) as Najwiekszy_Koszt, avg(Koszt) as �redni_Koszt 
from Wizyta
where Data_Wizyty LIKE '%';
	
select count(Choroba_Zwierz�cia.Id_Zwierz�cia) as Ilo��_Zwierz�t, Choroba.Zaka�liwos� from Choroba_Zwierz�cia
INNER JOIN Choroba ON Choroba.Id_Choroby=Choroba_Zwierz�cia.Id_Choroby
group by Choroba.Zaka�liwos�
order by count(Choroba_Zwierz�cia.Id_Zwierz�cia) DESC;

select count(Id_Zwierz�cia) as Ilo��_Zwierz�t, P�e� from Zwierze
group by Zwierze.P�e�

go 
create view [Visits from 2022] as
select Id_Wizyty from Wizyta
where Koszt > 150
go

