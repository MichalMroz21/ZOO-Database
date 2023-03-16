use Ogród_Zoologiczny;


select distinct Zwierze.Id_Zwierzêcia, Zwierze.Imiê FROM Dieta_Zwierzêcia
	INNER JOIN Zwierze ON Zwierze.Id_Zwierzêcia=Dieta_Zwierzêcia.Id_Zwierzêcia
	WHERE Dieta_Zwierzêcia.Kalorycznoœæ > 2000;
	
select Choroba_Zwierzêcia.Id_Zwierzêcia, Choroba.Nazwa FROM Choroba_Zwierzêcia
	INNER JOIN Choroba ON Choroba.Id_Choroby=Choroba_Zwierzêcia.Id_Choroby
	WHERE Choroba.ZakaŸliwosæ='Bardzo zakaŸliwa';

select Imiê, Nazwisko from Osoba
	where Id_Osoby in (select id_osoby from Pracownik_ZOO
							where Specjalizacja='Obs³uga finansowa');

select Zwierze.Id_Zwierzêcia, Zwierze.Imiê FROM Zwierze
	where Id_Zwierzêcia in (select Id_Zwierzêcia from Dieta_Zwierzêcia
								where Rodzaj='Z witaminami');

select Dieta_Zwierzêcia.Kalorycznoœæ, Dieta_Zwierzêcia.Id_Zwierzêcia
from Dieta_Zwierzêcia
where Dieta_Zwierzêcia.Rodzaj='Z witaminami' or Dieta_Zwierzêcia.Rodzaj='Hipoalergiczna'
order by Dieta_Zwierzêcia.Kalorycznoœæ DESC;

select min(Koszt) as Najmniejszy_Koszt, max(Koszt) as Najwiekszy_Koszt, avg(Koszt) as Œredni_Koszt 
from Wizyta
where Data_Wizyty LIKE '%';
	
select count(Choroba_Zwierzêcia.Id_Zwierzêcia) as Iloœæ_Zwierz¹t, Choroba.ZakaŸliwosæ from Choroba_Zwierzêcia
INNER JOIN Choroba ON Choroba.Id_Choroby=Choroba_Zwierzêcia.Id_Choroby
group by Choroba.ZakaŸliwosæ
order by count(Choroba_Zwierzêcia.Id_Zwierzêcia) DESC;

select count(Id_Zwierzêcia) as Iloœæ_Zwierz¹t, P³eæ from Zwierze
group by Zwierze.P³eæ

go 
create view [Visits from 2022] as
select Id_Wizyty from Wizyta
where Koszt > 150
go

