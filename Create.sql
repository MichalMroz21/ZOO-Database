use Ogr�d_Zoologiczny;

create table Osoba(
	Id_Osoby int primary key identity(1, 1) not null,
	PESEL char(11) not null unique,
	Nazwisko varchar(50) not null,
	Wiek int not null default 1 check (Wiek >= 0),
	Imi� varchar(50) not null
);

create table Zwierze(
	Id_Zwierz�cia int primary key identity(1,1) not null,
	Gatunek varchar(50) not null,
	P�e� char(1) not null,
	Wiek int not null default 1 check (Wiek >= 0),
	Imi� varchar(50) not null
); 

create table Choroba(
	Id_Choroby int primary key identity(1,1) not null,
	Typowe_Objawy varchar(100) not null,
	Zaka�liwos� varchar(50) not null default 'Nie wyst�puje',
	Nazwa varchar(50) not null
);

create table Choroba_Zwierz�cia(
	Id_Choroby int not null,
	Id_Zwierz�cia int not null,
	primary key(Id_Choroby, Id_Zwierz�cia), --klucz z�o�ony
	foreign key (Id_Choroby) references Choroba(Id_Choroby), 
	foreign key(Id_Zwierz�cia) references Zwierze(Id_Zwierz�cia),
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
	Id_Zwierz�cia int not null,
	foreign key (Id_Weterynarza) references Weterynarz(Id_Weterynarza), --zwi�zek z weterynarzem
	foreign key(Id_Choroby, Id_Zwierz�cia) references Choroba_Zwierz�cia(Id_Choroby, Id_Zwierz�cia), --zwi�zek z chorob� zwierz�cia, tzn. jest w wizycie ten klucz z�o�ony
	Data_Wizyty datetime not null,
	Koszt money not null check (Koszt >= 0)
);

create table Dieta_Zwierz�cia(
	Id_Wizyty int not null,
	Id_Zwierz�cia int not null,
	Id_Diety_Zwierz�cia int primary key identity(1001, 1) not null,
	foreign key (Id_Wizyty) references Wizyta(Id_Wizyty), --zwi�zek z wizyt�
	foreign key (Id_Zwierz�cia) references Zwierze(Id_Zwierz�cia), --zwi�zek z zwierz�ciem
	Kaloryczno�� int not null check (Kaloryczno�� > 0),
	Rodzaj varchar(50) not null
);

create table Sk�adnik(
	Id_Sk�adnika int primary key identity(1, 1) not null,
	Id_Diety_Zwierz�cia int not null,
	foreign key (Id_Diety_Zwierz�cia) references Dieta_Zwierz�cia(Id_Diety_Zwierz�cia), --zwi�zek z diet�
	Ilo�� int not null default 0,
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
	Id_Diety_Zwierz�cia int not null,
	foreign key(Id_Pracownika_ZOO) references Pracownik_ZOO(Id_Pracownika_ZOO), --zwi�zek z pracownikiem
	foreign key(Id_Diety_Zwierz�cia) references Dieta_Zwierz�cia(Id_Diety_Zwierz�cia), --zwi�zek z diet�
	Stopie�_niebezpiecze�stwa smallint not null default 1 check (Stopie�_niebezpiecze�stwa > 0 and Stopie�_niebezpiecze�stwa <= 3)
);