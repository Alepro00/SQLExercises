CREATE TABLE Citta(
	ID smallint(1) 			PRIMARY KEY,
	NomeCitta varchar(30) 	not null,
	Popolazione int			not null
	);
	
CREATE TABLE Acquedotti(
	Codice smallint(1)		PRIMARY KEY,
	NomeAcq		varchar(30)	not NULL
	);
	
CREATE TABLE Fornitura(
	Citta		smallint(1)	not null,
	Acquedotto	smallint(1) not null,
	Portata		int			not null,
	FOREIGN KEY(Citta) REFERENCES Citta(ID),
	FOREIGN KEY(Acquedotto) REFERENCES Acquedotti(Codice)
	);