CREATE DATABASE Esercitazione1;

/*Pazienti(CF, Nome, DataRicovero, Datadimissione, MedicoCurante*)
Medici(CF, Nome)
Malattie(Codice, Denominazione, Terapia)
Soffre(Paziente*, Malattia*, DataInizio)
Specialisti(Medico*, Specializzazione*)
Specializzazione(Codice, Nome)
Appartenenza(Specializzazione, Malattia)*/

CREATE TABLE Medici
(CF char(16) primary key,
 Nome varchar(50)
);

CREATE TABLE Malattie
(Codice char(5) primary key,
 Denominazione varchar(45) not null,
 Terapia varchar(100) not null
);

CREATE TABLE Pazienti
(CF char(16) primary key,
 Nome varchar(50) NOT NULL,
 DataRicovero Date,
 Datadimissione Date,
 MedicoCurante char(16) not null,
 FOREIGN KEY(MedicoCurante) REFERENCES Medici(CF)
);

CREATE TABLE Soffre
(Paziente char(16) not null,
 Malattia char(5) not null,
 DataInizio Date not null,
 FOREIGN KEY(Paziente) REFERENCES Pazienti(CF),
 FOREIGN KEY(Malattia) REFERENCES Malattie(Codice)
);

CREATE TABLE Specializzazioni
(Codice char(4) PRIMARY KEY,
 Nome char(35) not null
);

CREATE TABLE Specialisti
(Medico char(16) not null,
 Specializzazione char(4) not null,
 FOREIGN KEY (Medico) REFERENCES Medici(CF),
 FOREIGN KEY (Specializzazione) REFERENCES Specializzazioni(Codice)
);

CREATE TABLE Appartenenza
(Specializzazione char(4) not null,
 Malattia char(5) not null,
 FOREIGN KEY (Specializzazione) REFERENCES Specializzazioni(Codice),
 FOREIGN KEY (Malattia) REFERENCES Malattie(Codice)
)


INSERT INTO malattie VALUES(00001, 'rinite allergica', 'terapia'); 
INSERT INTO Medici VALUES('WERTYAGF345JKLP0', 'Mario Rossi');
INSERT INTO Pazienti VALUES('QUTRHEGFDVBNM098', 'Alessandro Albertini', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Soffre VALUES('QUTRHEGFDVBNM098', 00001, 23/12/2022);

UPDATE Pazienti SET DataRicovero='06/11/2022' WHERE Nome='Alessandro Albertini'


/*ESERCIZIO 1
Trovare il Codice Fiscale e i nomi di tutti i pazienti affetti da rinite allergica che hanno come medico
curante il Dott. Mario Rossi*/

SELECT Pazienti.CF, Pazienti.Nome
FROM Pazienti, Medici, Soffre, malattie
WHERE Pazienti.MedicoCurante=Medici.CF AND pazienti.CF=soffre.Paziente AND soffre.Malattia = malattie.Codice AND
medici.Nome='Mario Rossi' AND malattie.Denominazione='rinite allergica'


/*MODIFICHE*/

UPDATE Pazienti SET DataRicovero='2022/11/06' WHERE Nome='Alessandro Albertini';
UPDATE Soffre SET DataInizio='2022/12/23' WHERE (SELECT CF FROM pazienti WHERE Nome='Alessandro Albertini')=Paziente




/*ESERCIZIO 2
Trovare nome e codice fiscale dei pazienti che sono stati ricoverati senza 
che alla data del ricovero
soffrissero di alcuna malattia.
*/

SELECT Pazienti.Nome, Pazienti.CF
FROM Pazienti, Soffre
WHERE Pazienti.CF=Soffre.Paziente AND Pazienti.DataRicovero<>Soffre.DataInizio


/*
MODIFICARE LE TABELLE PER L'ESERCIZIO 3
*/
INSERT INTO malattie VALUES(00002, 'Acne giovanile', 'terapia'); 
INSERT INTO Soffre VALUES('QUTRHEGFDVBNM098', 00002, '10/02/2022');

INSERT INTO malattie VALUES(00003, 'Acufene', 'terapia'); 
INSERT INTO Soffre VALUES('QUTRHEGFDVBNM098', 00003, '10/02/2022');

INSERT INTO Specializzazioni VALUES(10,'Apparato uditivo');
INSERT INTO Specializzazioni VALUES(20,'Pelle');

INSERT INTO Appartenenza VALUES(10,2);
INSERT INTO Appartenenza VALUES(20,3);

INSERT INTO Specialisti VALUES('WERTYAGF345JKLP0',10);
INSERT INTO Specialisti VALUES('WERTYAGF345JKLP0',20);



INSERT INTO Specializzazioni VALUES(30,'Allergia');
INSERT INTO Specialisti VALUES('WERTYAGF345JKLP0',30);



/*ESERCIZIO 3
Trovare nome e codice fiscale dei pazienti il cui medico curante 
è specialista di tutte le malattie di
cui il paziente stesso soffre.*/

SELECT ALL Pazienti.Nome AS NomePaziente, Pazienti.CF AS CFPaziente
FROM Pazienti, Medici, Specialisti,Specializzazioni, Appartenenza, Soffre
WHERE 	/*JOIN TRA MEDICI E PAZIENTI (MEDICO CURANTE)*/
		Pazienti.MedicoCurante=Medici.CF AND 
		/*JOIN TRA MEDICI E SPECIALISTI*/
		Medici.CF=Specialisti.Medico AND 
		/*JOIN TRA SPECIALIZZAZIONE E SPECIALISTI*/
		Specialisti.Specializzazione=Specializzazioni.Codice AND
		/*JOIN TRA SPECIALIZZAZIONE E APPARTENENZA*/
		Specializzazioni.Codice=Appartenenza.Specializzazione AND
		/*JOIN TRA PAZIENTI E SOFFRE*/
		Pazienti.CF=Soffre.Paziente AND
		
		Soffre.Malattia=Appartenenza.Malattia
		
GROUP BY Pazienti.CF
/*
HAVING (SELECT COUNT(*) 
	   FROM Pazienti,Soffre
	   WHERE Pazienti.CF=Soffre.Paziente
	   GROUP BY Pazienti.CF)
	   = (SELECT COUNT(*) 
		 FROM Appartenenza, Specializzazioni
		 WHERE Appartenenza.Specializzazione=Specializzazioni.Codice);
	
*/
	
/*INSERIMENTO DI UN ALTRO MEDICO ALTRE MALATTIE E  SPECIALIZZAZIONI
*/

INSERT INTO Medici VALUES('POKFKDJRTEGHW435','Luigi Neri');

INSERT INTO Malattie VALUES(4,'Alzheimer','terapia');
INSERT INTO Malattie VALUES(5,'Diabete','terapia');

insert into Specializzazioni VALUES(40,'Memoria');
insert into Specializzazioni VALUES(50,'Dietologia');

insert into Appartenenza VALUES(40,4);
insert into Appartenenza VALUES(50,5);

INSERT INTO Specialisti VALUES('POKFKDJRTEGHW435',40);
INSERT INTO Specialisti VALUES('POKFKDJRTEGHW435',50);

INSERT INTO Pazienti VALUES('MNGDFSHJKIRETW23','Giuseppa Giacalone', NULL, NULL,'POKFKDJRTEGHW435');

INSERT INTO Soffre VALUES('MNGDFSHJKIRETW23',4,'22/08/2010');
INSERT INTO Soffre VALUES('MNGDFSHJKIRETW23',5,'07/09/2017');



/*ESERCIZIO 4
Trovare nome e codice fiscale dei medici che hanno almeno 4 specializzazioni e che hanno in cura
almeno 10 pazienti.
*/

SELECT Medici.CF, COUNT(DISTINCT specialisti.Specializzazione) AS Vaffanculo1, COUNT(DISTINCT pazienti.CF) AS Vaffanculo2
FROM medici, Specialisti, Pazienti
WHERE Medici.CF=specialisti.Medico AND pazienti.MedicoCurante=medici.CF
GROUP BY medici.CF;
HAVING Vaffanculo1>2 AND Vaffanculo2>=10 /*AND

	
	
/*INSERIMENTO PAZIENTI*/
INSERT INTO Pazienti VALUES('QUTRHEGFDVFNM098', 'Alessandro Albertini', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Pazienti VALUES('QUTRHEGFDVNNM098', 'Martina Francescana', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Pazienti VALUES('QUTRHEGFDVBNM098', 'Denisa Genoveffi', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Pazienti VALUES('QUTRHEGFGVBNM098', 'Alisia Castori', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Pazienti VALUES('QUTRHEGFUVBNM098', 'Giancarla Emozionati', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Pazienti VALUES('QUTREEGFDVBNM098', 'Paoletta Giancarlita', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Pazienti VALUES('QUwwwEGFGVBNM098', 'Alisia Castoretta', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Pazienti VALUES('QUPPPEGFUVBNM098', 'Carla Emozionatissima', NULL, NULL,'WERTYAGF345JKLP0');
INSERT INTO Pazienti VALUES('QUTREEGLLLBNM098', 'Giuseppa Ciddara', NULL, NULL,'WERTYAGF345JKLP0');


/*Trovare il nome dei pazienti che sono stati ricoverati nel periodo consecutivo più lungo.*/

SELECT MAX(DATEDIFF(pazienti.Datadimissione,pazienti.DataRicovero)) 
FROM Pazienti; 


/*Indicare i nomi dei medici che hanno il maggior numero di specializzazioni, indicando anche tale numero*/

SELECT COUNT(Specialisti.specializzazione)
FROM Specialisti, Medici
WHERE Medici.CF=Specialisti.Medici
GROUP BY Specialisti.Medici














