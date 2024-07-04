CREATE DATABASE Mobilificio;
USE Mobilificio;

CREATE TABLE Categorie(
	cat_cod char(3) primary key,
	cat_descrizione varchar(30) not null
);

CREATE TABLE Laboratori(
	lab_cod char(4) primary key,
	lab_indirizzo varchar(30) not null,
	lab_città varchar(20) not null,
	lab_telefono varchar(14) unique not null
);

CREATE TABLE Negozi(
	Neg_cod char(4) primary key,
	Neg_nome varchar(30) not null,
	Neg_indirizzo varchar(30),
	Neg_città varchar(20),
	Neg_telefono varchar(14)
);

CREATE TABLE Ordini(
	Ord_cod char(6) primary key,
	Neg_cod char(4),
	Ord_data date,
	FOREIGN KEY(Neg_cod) REFERENCES Negozi(Neg_cod) 
);

CREATE TABLE OrdArt(
	Ord_cod char(6),
	Art_cod char(3) primary key,
	OrdArt_qta smallint

);

CREATE TABLE Articoli(
	Art_cod	char(3) primary key,
	Cat_cod char(3),
	Art_descrizione varchar(30),
	Art_prezzo	double(5,2),
	Art_IVA	tinyint,
	Art_SpeseTrasporto double, 
	FOREIGN KEY(Cat_cod) REFERENCES Categorie(Cat_cod)
);


CREATE TABLE Componenti(
	Com_cod char(4) primary key,
	Com_descrizione varchar(30),
	Com_costo double (5,2),
	Lab_cod char(4),
	FOREIGN KEY(Lab_cod) REFERENCES Laboratori(Lab_cod)

);


CREATE TABLE CompArt(
	Art_cod char(3),
	Com_cod char(4),
	CompArt_qta smallint,
	FOREIGN KEY(Com_cod) REFERENCES Componenti(Com_cod),
	FOREIGN KEY(Art_cod) REFERENCES Articoli(Art_cod)
);


