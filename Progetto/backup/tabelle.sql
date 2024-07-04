DROP DATABASE PROGETTO;
CREATE DATABASE PROGETTO;

CREATE TABLE Negozio(
Cod_negozio smallint(7) NOT NULL AUTO_INCREMENT,
Nome varchar(50) NOT NULL,
Rec_telefonico varchar(15) NOT NULL,
    
PRIMARY KEY(Cod_negozio)
);

CREATE TABLE Categoria(
Id_categoria smallint(4),
Nome varchar(30) NOT NULL,
    
PRIMARY KEY(Id_categoria)
);


CREATE TABLE Nazione(
Id_nazione smallint(3) NOT NULL,
Nome varchar(30) NOT NULL,

PRIMARY KEY(Id_nazione)
);

CREATE TABLE Regione(
Id_regione int NOT NULL,
Id_nazione smallint(3) not NULL,
Nome varchar(30) NOT NULL,

PRIMARY KEY(Id_regione),
FOREIGN KEY(Id_nazione) REFERENCES Nazione(Id_nazione)
);

CREATE TABLE Citta(
Id_citta int NOT NULL,
Id_regione int NOT NULL,
Nome varchar(30) NOT NULL,	

PRIMARY KEY(Id_citta),
FOREIGN KEY(Id_regione) REFERENCES Regione(Id_regione)
);

/*TABELLE GESTIONE DELL'INDIRIZZO*/
CREATE TABLE Indirizzo(
Id_indirizzo int NOT NULL AUTO_INCREMENT,
Id_citta int NOT NULL,
Nome varchar(50) NOT NULL,
Num_civico int NOT NULL,

PRIMARY KEY(Id_indirizzo),
FOREIGN KEY(Id_citta) REFERENCES Citta(Id_citta)
);

CREATE TABLE Magazzino(
Cod_magazzino varchar(5) NOT NULL,
Id_indirizzo int NOT NULL,
    
PRIMARY KEY(Cod_magazzino),
FOREIGN KEY(Id_indirizzo) REFERENCES Indirizzo(Id_indirizzo)
);


CREATE TABLE Articolo(
Cod_articolo varchar(10) NOT NULL,
Cod_negozio smallint(7) NOT NULL,
Cod_magazzino varchar(5) NOT NULL,
Id_categoria smallint(4) NOT NULL,
Nome varchar(50) NOT NULL,
Descrizione varchar(500) NOT NULL,
Quantita int NOT NULL DEFAULT 0
CHECK (Quantita>=0),

PRIMARY KEY(Cod_articolo),
FOREIGN KEY(Cod_negozio) REFERENCES Negozio(Cod_negozio),
FOREIGN KEY(Cod_magazzino) REFERENCES Magazzino(Cod_magazzino),
FOREIGN KEY(Id_categoria) REFERENCES Categoria(Id_categoria) 
);

CREATE TABLE Prezzo(
Id_prezzo int AUTO_INCREMENT primary key,
Cod_articolo varchar(10) NOT NULL,
Prezzo double(7,2) NOT NULL
CHECK (Prezzo>0),
Sconto int(2) DEFAULT 0 /*Imposto uno sconto dello 0% se non viene inserito nulla*/
CHECK (Sconto>=0 AND Sconto<100),


/*PRIMARY KEY(Id_prezzo),*/
FOREIGN KEY(Cod_articolo) REFERENCES Articolo(Cod_articolo)
);


/*------------------------------------ */

CREATE TABLE Acquirente(
Id_acquirente int NOT NULL,
id_indirizzo_cons int NOT NULL,
Nome varchar(30) NOT NULL,
Cognome varchar(30) NOT NULL,
Email varchar(50) NOT NULL,
Genere char(1) NOT NULL
 CHECK (Genere IN ('M', 'F', 'N')), /*Maschio, Femmina, Non specificato*/
 Password varchar(24) NOT NULL,
 Data_nascita date NOT NULL,
 
 PRIMARY KEY(Id_acquirente),
 FOREIGN KEY(Id_indirizzo_cons) REFERENCES Indirizzo(Id_indirizzo)
);

CREATE TABLE Recensioni(
Cod_recensioni varchar(5) NOT NULL,
Cod_articolo varchar(10) NOT NULL, 
Id_acquirente int NOT NULL,
Stelle smallint(1) NOT NULL /*Se inserisci una recensione devi mette a forza un num di stelle*/
CHECK (Stelle IN (1,2,3,4,5)), 
Commento varchar(200) DEFAULT '',

PRIMARY KEY(Cod_recensioni),
FOREIGN KEY(Cod_articolo) REFERENCES Articolo(Cod_articolo),
FOREIGN KEY(Id_acquirente) REFERENCES Acquirente(Id_acquirente)
);


CREATE TABLE Acquisto(
Id_acquirente int NOT NULL,
Cod_articolo varchar(10) NOT NULL,
Data_acquisto datetime DEFAULT NOW(),
Acquistato Boolean DEFAULT 0, /*Se è true è un ordine, se è false è ancora nel carrello*/
Quantita int NOT NULL
CHECK (Quantita>=1),

PRIMARY KEY (Id_acquirente, Cod_articolo),
FOREIGN KEY(Id_acquirente) REFERENCES Acquirente(Id_acquirente),
FOREIGN KEY(Cod_articolo) REFERENCES Articolo(Cod_articolo)
);

CREATE TABLE Carta(
Num_carta char(16) NOT NULL,
Id_acquirente int NOT NULL,
Titolare varchar(60) NOT NULL,
Cvv smallint(3) NOT NULL,
Scadenza_mese smallint(2) NOT NULL
CHECK (Scadenza_mese >0 && Scadenza_mese <13),
Scadenza_anno year NOT NULL,




PRIMARY KEY(Num_carta),
FOREIGN KEY(Id_acquirente) REFERENCES Acquirente(Id_acquirente)
);