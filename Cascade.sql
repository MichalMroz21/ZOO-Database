use Ogród_Zoologiczny;

--on cascade delete, jak przypisze go do fk childa i usune rowa w parencie ktory ma to samo fk, to w childzie rowniez usunie sie row z tym samym fk.
--1. parent: Osoba, child: Weterynarz
alter table Karmienie
drop constraint if exists Id_Diety_Zwierzêcia

alter table Karmienie
add constraint Id_Diety_Zwierzêcia
	foreign key	(Id_Diety_Zwierzêcia)
	references Dieta_Zwierzêcia (Id_Diety_Zwierzêcia)
	on delete cascade

alter table Sk³adnik
drop constraint if exists Id_Diety_Zwierzêcia2

alter table Sk³adnik
add constraint Id_Diety_Zwierzêcia2
	foreign key	(Id_Diety_Zwierzêcia)
	references Dieta_Zwierzêcia (Id_Diety_Zwierzêcia)
	on delete cascade

alter table Dieta_Zwierzêcia
drop constraint if exists Id_Wizyty

alter table Dieta_Zwierzêcia
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