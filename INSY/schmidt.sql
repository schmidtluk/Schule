create table Allergene
(
	Nummeration char(1) not null
		primary key,
	VolleBezeichnung varchar(50)
)
go

create table Gasthaus
(
	NameGasthaus varchar(50) not null
		primary key,
	NummerKarte int
)
go

create table Kategorie
(
	NameKategorie varchar(50) not null
		primary key,
	NummerKarte int
)
go

create table Rechnung
(
	NummerRechnung int not null
		primary key,
	DateTime datetime,
	Danksagung varchar(500),
	Kopfzeile varchar(500)
)
go

create table Speise
(
	NameSpeise varchar(50) not null
		primary key,
	Preis float,
	Steuersatz float,
	NameKategorie varchar(50)
		constraint Speise_Kategorie_NameKategorie_fk
			references Kategorie
)
go

create table Speisekarte
(
	NummerKarte int not null
		primary key
)
go

alter table Gasthaus
	add constraint Gasthaus_Speisekarte_NummerKarte_fk
		foreign key (NummerKarte) references Speisekarte
go

alter table Kategorie
	add constraint Kategorie_Speisekarte_NummerKarte_fk
		foreign key (NummerKarte) references Speisekarte
go

create table Tisch
(
	NummerTisch int not null
		primary key,
	AnzSitze int,
	Bezeichnung varchar(50),
	NameGasthaus varchar(50)
		constraint Tisch_Gasthaus_NameGasthaus_fk
			references Gasthaus,
	NummerRechnung int
		constraint Tisch_Rechnung_NummerRechnung_fk
			references Rechnung
)
go

create table Werbung
(
	Bezeichnung varchar(50) not null
		primary key,
	Zeitrahmen datetime,
	Auftraggeber varchar(50)
)
go

create table beinhaltet
(
	NameSpeise varchar(50)
		constraint beinhaltet_Speise_NameSpeise_fk
			references Speise,
	Nummeration char(1) not null
		primary key
		constraint beinhaltet_Allergene_Nummeration_fk
			references Allergene
)
go

create table druckt
(
	NummerRechnung int
		constraint druckt_Rechnung_NummerRechnung_fk
			references Rechnung,
	Bezeichnung varchar(50) not null
		primary key
		constraint druckt_Werbung_Bezeichnung_fk
			references Werbung
)
go

