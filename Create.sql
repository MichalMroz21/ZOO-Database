use Ogród_Zoologiczny;

create table Osoba(
	Id_Osoby int primary key identity(1, 1) not null,
	PESEL char(11) not null unique,
	Nazwisko varchar(50) not null,
	Wiek int not null default 1 check (Wiek >= 0),
	Imiê varchar(50) not null
);

create table Zwierze(
	Id_Zwierzêcia int primary key identity(1,1) not null,
	Gatunek varchar(50) not null,
	P³eæ char(1) not null,
	Wiek int not null default 1 check (Wiek >= 0),
	Imiê varchar(50) not null
); 

create table Choroba(
	Id_Choroby int primary key identity(1,1) not null,
	Typowe_Objawy varchar(100) not null,
	ZakaŸliwosæ varchar(50) not null default 'Nie wystêpuje',
	Nazwa varchar(50) not null
);

create table Choroba_Zwierzêcia(
	Id_Choroby int not null,
	Id_Zwierzêcia int not null,
	primary key(Id_Choroby, Id_Zwierzêcia), --klucz z³o¿ony
	foreign key (Id_Choroby) references Choroba(Id_Choroby), 
	foreign key(Id_Zwierzêcia) references Zwierze(Id_Zwierzêcia),
	Data_Zachorowania datetime not null,
	Objawy varchar(100) not null,
);

create table Weterynarz(
	Id_Weterynarza int primary key identity(101, 1) not null,
	Id_Osoby int not null,
	foreign key(Id_Osoby) references Osoba(Id_Osoby),
	PESEL char(11) not null,
	foreign key (PESEL) references Osoba(PESEL),
	Specjalizacja_Weterynarska varchar(50) not null,
	Czas_Wykonywania_Zawodu datetime not null
);

create table Wizyta(
	Id_Wizyty int primary key identity(10001, 1) not null,
	Id_Weterynarza int not null,
	Id_Choroby int not null,
	Id_Zwierzêcia int not null,
	foreign key (Id_Weterynarza) references Weterynarz(Id_Weterynarza), --zwi¹zek z weterynarzem
	foreign key(Id_Choroby, Id_Zwierzêcia) references Choroba_Zwierzêcia(Id_Choroby, Id_Zwierzêcia), --zwi¹zek z chorob¹ zwierzêcia, tzn. jest w wizycie ten klucz z³o¿ony
	Data_Wizyty datetime not null,
	Koszt money not null check (Koszt >= 0)
);

create table Dieta_Zwierzêcia(
	Id_Wizyty int not null,
	Id_Zwierzêcia int not null,
	Id_Diety_Zwierzêcia int primary key identity(1001, 1) not null,
	foreign key (Id_Wizyty) references Wizyta(Id_Wizyty), --zwi¹zek z wizyt¹
	foreign key (Id_Zwierzêcia) references Zwierze(Id_Zwierzêcia), --zwi¹zek z zwierzêciem
	Kalorycznoœæ int not null check (Kalorycznoœæ > 0),
	Rodzaj varchar(50) not null
);

create table Sk³adnik(
	Id_Sk³adnika int primary key identity(1, 1) not null,
	Id_Diety_Zwierzêcia int not null,
	foreign key (Id_Diety_Zwierzêcia) references Dieta_Zwierzêcia(Id_Diety_Zwierzêcia), --zwi¹zek z diet¹
	Iloœæ int not null default 0,
	Waga int not null default 1 check (Waga > 0), --w kg
	Cena int not null default 0 check (Cena >= 0), --w PLN
	Nazwa char(50) not null
);

create table Pracownik_ZOO(
	Id_Pracownika_ZOO int primary key identity(111, 1) not null,
	Id_Osoby int not null, 
	foreign key(Id_Osoby) references Osoba(Id_Osoby),
	Stanowisko varchar(50) not null,
	Specjalizacja varchar(50) not null default 'brak'
);

create table Karmienie(
	Id_Karmienia int primary key identity(10001, 1) not null,
	Id_Pracownika_ZOO int not null,
	Id_Diety_Zwierzêcia int not null,
	foreign key(Id_Pracownika_ZOO) references Pracownik_ZOO(Id_Pracownika_ZOO), --zwi¹zek z pracownikiem
	foreign key(Id_Diety_Zwierzêcia) references Dieta_Zwierzêcia(Id_Diety_Zwierzêcia), --zwi¹zek z diet¹
	Stopieñ_niebezpieczeñstwa smallint not null default 1 check (Stopieñ_niebezpieczeñstwa > 0 and Stopieñ_niebezpieczeñstwa <= 3)
);