use Ogr�d_Zoologiczny;

--on cascade delete, jak przypisze go do fk childa i usune rowa w parencie ktory ma to samo fk, to w childzie rowniez usunie sie row z tym samym fk.
--1. parent: Osoba, child: Weterynarz
alter table Karmienie
drop constraint if exists Id_Diety_Zwierz�cia

alter table Karmienie
add constraint Id_Diety_Zwierz�cia
	foreign key	(Id_Diety_Zwierz�cia)
	references Dieta_Zwierz�cia (Id_Diety_Zwierz�cia)
	on delete cascade

alter table Sk�adnik
drop constraint if exists Id_Diety_Zwierz�cia2

alter table Sk�adnik
add constraint Id_Diety_Zwierz�cia2
	foreign key	(Id_Diety_Zwierz�cia)
	references Dieta_Zwierz�cia (Id_Diety_Zwierz�cia)
	on delete cascade

alter table Dieta_Zwierz�cia
drop constraint if exists Id_Wizyty

alter table Dieta_Zwierz�cia
add constraint Id_Wizyty
	foreign key	(Id_Wizyty)
	references Wizyta (Id_Wizyty)
	on delete cascade

alter table Wizyta
drop constraint if exists Id_Weterynarza

alter table Wizyta
add constraint Id_Weterynarza
	foreign key	(Id_Weterynarza)
	references Weterynarz (Id_Weterynarza)
	on delete cascade

alter table Weterynarz
drop constraint if exists Id_Osoby

alter table Weterynarz
add constraint Id_Osoby
	foreign key	(Id_Osoby)
	references Osoba (Id_Osoby)
	on delete cascade

alter table Weterynarz
drop constraint if exists PESEL

alter table Weterynarz
add constraint PESEL
	foreign key (PESEL)
	references Osoba (PESEL)
	on update cascade
	
delete from Osoba
	where Id_Osoby = 3;

update Osoba 
set PESEL = '00000000000'
where Id_Osoby = 4

select * from Osoba