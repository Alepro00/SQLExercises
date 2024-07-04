CREATE DATABASE Universita;
USE Universita;
/*Dentro il database universita creare una tabella studenti
che contiene matricola di 8 caratteri, nome (fino a 20
caratteri) cognome (fino a 20 caratteri) data di nascita e
numero di esami effettuati, senza specificare alcun vincolo.*/

CREATE TABLE Studenti(
	Matricola char(8),
	Nome varchar(20)  not null,
	Cognome varchar(20) not null,
	Data_Nascita Date 	not null,
	Num_esami int
);

/*ALTER TABLE Studenti ADD Media_voti number(4,2)
CHECK (Media_voti>=18 AND Media_voti<=30);*/
ALTER TABLE Studenti ADD Media_voti /*number*/DOUBLE(4,2);
ALTER TABLE Studenti /*ADD*/ CHECK (Media_voti>=18 AND Media_voti<=30);

/*Aggiungere vincolo*/
;

/*Dopo aver creato la tabella studenti, aggiungere una
colonna con la media dei voti (4 cifre di cui due decimali)
imponendo il vincolo che tale media deve essere compresa
tra 18 e 30.*/

/*Aggiungere quindi le colonne telefono (fino a 15 caratteri)
ed email (fino a 20 caratteri)*/

ALTER TABLE Studenti ADD COLUMN Telefono varchar(15);
ALTER TABLE Studenti ADD COLUMN Email varchar(20);

ALTER TABLE Studenti ADD (
Telefono varchar(15),
Email varchar(20));

/*Quindi modificare la colonna matricola in modo tale
da renderla chiave primaria.*/

ALTER TABLE Studenti ADD PRIMARY KEY(Matricola);

ALTER TABLE Studenti MODIFY Matricola char(6) PRIMARY KEY

/*Aggiungere un vincolo di tabella, specificando che la
tripla nome cognome e data di nascita non può essere
uguale per diversi studenti. Attribuire al vincolo un
identificatore*/

ALTER TABLE Studenti ADD CONSTRAINT Tupla UNIQUE (Nome, Cognome, Data_Nascita);

/*Cancellare la colonna relativa al numero di esami
effettuati*/

ALTER TABLE Studenti DROP COLUMN Num_esami;

/*Eliminare il vincolo creato al punto 6.*/

ALTER TABLE Studenti DROP CONSTRAINT Tupla;

/*Eliminare le colonne email e numero di telefono*/

ALTER TABLE Studenti DROP COLUMN Email;
ALTER TABLE Studenti DROP COLUMN Telefono;

/*Inserire la tabella DOCENTI con MatrD di 6
caratteri, Nome e Cognome con al più 20 caratteri*/


CREATE TABLE  Docenti(
	MatrD char(6),
	Nome varchar(20),
	Cognome varchar(20)

)

/*Inserire la tabella CORSI, con CodiceC di 5
caratteri, denominazione con al più 20 caratteri,
numero crediti (intero) e docente di 6 caratteri con
riferimento all’attributo MatrD della tabella Docenti*/

CREATE TABLE Corsi(
	CodiceC char(5),
	Denominazione varchar(20),
	num_crediti int,
	Docente char(6),
	FOREIGN KEY (Docente) REFERENCES Docenti(MatrD)
)

/*Inserire la tabella ESAMI con studente, corso,
voto, inserendo opportuni riferimenti a tabelle
esterne e opportuna chiave primaria*/

CREATE TABLE Esami(
	Cod_esame char(7) primary key,
	Studente char(8),
	Corso char(5),
	Voto smallint,
	FOREIGN KEY Studente REFERENCES Studenti(Matricola),
	FOREIGN KEY Corso REFERENCES Corsi(CodiceC),
	CHECK Voto(BETWEEN 0 AND 30)

)