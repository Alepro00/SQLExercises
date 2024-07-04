/*Nazioni*/
INSERT INTO nazione VALUES(113,'Italia');
INSERT INTO nazione VALUES(203,'Stati Uniti');
/*Regioni*/
INSERT INTO regione VALUES(0, 113,'Sicilia');
INSERT INTO regione VALUES(1, 113,'Campania');
INSERT INTO regione VALUES(2, 113,'Lazio');

INSERT INTO regione VALUES(3, 203,'New England');
INSERT INTO regione VALUES(4, 203,'Virginia');
INSERT INTO regione VALUES(5, 203,'Columbia');

/*Citta*/
INSERT INTO citta VALUES(0,0,'Palermo');
INSERT INTO citta VALUES(1,1,'Napoli');
INSERT INTO citta VALUES(2,2,'Roma');

INSERT INTO citta VALUES(3,3,'Boston');
INSERT INTO citta VALUES(4,4,'Richmond');
INSERT INTO citta VALUES(5,5,'Washington');

/*Indirizzi*/
INSERT INTO indirizzo(Id_citta, Nome, Num_civico) VALUES(0,'Via Archirafi',34);
INSERT INTO indirizzo(Id_citta, Nome, Num_civico) VALUES(1,'Via Incoronata',14);
INSERT INTO indirizzo(Id_citta, Nome, Num_civico) VALUES(2,'Via Citta delle Pieve',42);

INSERT INTO indirizzo(Id_citta, Nome, Num_civico) VALUES(3,'Cambridge St',108);
INSERT INTO indirizzo(Id_citta, Nome, Num_civico) VALUES(4,'Upper Richmond Rd',73);
INSERT INTO indirizzo(Id_citta, Nome, Num_civico) VALUES(5,'1st St NW',1828);

/*--------------------------------------------------------------*/

/*NEGOZI*/
INSERT INTO Negozio(Nome, Rec_telefonico) VALUES('Electronic Store', 091564328);
INSERT INTO Negozio(Nome, Rec_telefonico) VALUES('Pet Store', 091124356);


/*CATEGORIE*/
INSERT INTO Categoria VALUES(2000, 'Sport');
INSERT INTO Categoria VALUES(1001, 'Elettronica');
INSERT INTO Categoria VALUES(2001, 'Svago e tempo libero');

/*MAGAZZINI*/
INSERT INTO Magazzino VALUES(10001, 4);
INSERT INTO Magazzino VALUES(10002, 5);

/*ARTICOLI*/
INSERT INTO Articolo VALUES('AHDFS123', 1, 10001, 1001, 'Corsair VENGEANCELPX16GB DDR4 3600', 'Slot di ram DDR4 da 16GB per pc fisso',5);
INSERT INTO Articolo VALUES('AHDDV222', 2, 10002, 2001, 'Friskies Vitafit Mini Menu', 'Friskies Vitafit Mini Menu Crocchette per Cani fino a 10 kg, con Pollo e Verdure Aggiunte, 1.5 kg ', 5);
INSERT INTO `articolo` (`Cod_articolo`, `Cod_negozio`, `Cod_magazzino`, `Id_categoria`, `Nome`, `Descrizione`, `Quantita`) 
VALUES ('ASDDV226', '2', '10002', '2001', 'Collare per cani viola con targhetta a forma di osso', 'Il collare ideale per il tuo cane! Compralo!', '12'),
 ('ASDDV422', '1', '10001', '1001', 'Mouse da Gaming DPI 4000 ultra sensibile TRUST', '', '20'),
 ('SHDUV232', '1', '10001', '1001', 'Tastiera Gaming retroilluminata Meccanica TRUST', '', '24'),
 ('AHSST622', '2', '10002', '2000', 'Scarpe da Corsa ideali per correre', 'Ottime scarpe da corsa ideali per correre insieme al proprio cane!', '6');
/*PREZZI*/
INSERT INTO Prezzo(Cod_articolo, Prezzo, Sconto) VALUES('AHDFS123', 69.99, 16);
INSERT INTO Prezzo(Cod_articolo, Prezzo, Sconto) VALUES('AHDDV222', 7.57, 0);
INSERT INTO `prezzo` (`Id_prezzo`, `Cod_articolo`, `Prezzo`, `Sconto`) 
VALUES ('3', 'AHSST622', '60', '10'), ('4', 'ASDDV226', '14.99', '10'), 
('5', 'ASDDV422', '29.99', '0'), ('6', 'SHDUV232', '29.99', '0');

/*ACQUIRENTI (Id_acquirente, Id_Indirizzo_cons, Nome, Cognome, Email, Genere, Password, data_nascita)*/
INSERT INTO Acquirente VALUES(20098, 1, 'Mario', 'Rossi', 'mariorossi@gmail.com', 'M', 'jfd676rtyu@]iuy3q', '1987/11/01');
INSERT INTO `acquirente` (`Id_acquirente`, `id_indirizzo_cons`, `Nome`, `Cognome`, `Email`, `Genere`, `Password`, `Data_nascita`) 
VALUES ('20099', '6', 'Alessandro', 'Lo Bosco', 'alessandro@gmail.com', 'M', 'dfibnefwo2£@', '2000/03/12'), 
('20100', '2', 'Pietro', 'Gialli', 'pietro@gmail.com', 'M', 'dvih jbvkjwn3', '1968/01/23');


/*Acquisto (Id_acquirente, Cod_articolo, Data_acquisto, Acquistato, Quantita CHECK (Quantita>=1),*/
INSERT INTO Acquisto(Id_acquirente, Cod_articolo, Quantita) VALUES(20098, 'AHDDV222', /*GETDATE(), 1,*/ 3);
INSERT INTO Acquisto(Id_acquirente, Cod_articolo, Quantita) VALUES(20098, 'AHDFS123', /*GETDATE(), 1,*/ 3);
INSERT INTO `acquisto` (`Id_acquirente`, `Cod_articolo`, `Data_acquisto`, `Acquistato`, `Quantita`) 
VALUES ('20100', 'ASDDV422', current_timestamp(), '0', '4'), 
('20099', 'SHDUV232', current_timestamp(), '0', '2');


/*RECENSIONI*/
INSERT INTO `recensioni` (`Cod_recensioni`, `Cod_articolo`, `Id_acquirente`, `Stelle`, `Commento`) 
VALUES ('A0001', 'AHDDV222', '20099', '4', 'Il mio cane li mangia che è un piacere, non costano neanche troppo.'),
 ('A0002', 'AHDFS123', '20098', '5', 'Ottime ram, sono molto soddisfatto.'), 
 ('A0003', 'AHSST622', '20100', '3', 'Non cosi comode come immaginavo, forse sarebbe stato meglio una taglia in più...'), 
 ('A0004', 'ASDDV226', '20099', '4', ''), 
('A0005', 'ASDDV422', '20100', '2', 'Per il prezzo che ha non sono tanto soddisfatto, è un normale mouse, mi aspettavo qualcosa in piu'), 
('A0006', 'SHDUV232', '20100', '4', 'Buona tastiera, retroilluminata e tutto.');
INSERT INTO `recensioni` (`Cod_recensioni`, `Cod_articolo`, `Id_acquirente`, `Stelle`, `Commento`) 
VALUES ('A0007', 'AHDDV222', '20098', '3', ''), ('A0008', 'AHDDV222', '20100', '2', '');

/*Carta*/
INSERT INTO `carta` (`Num_carta`, `Id_acquirente`, `Titolare`, `Cvv`, `Scadenza_mese`, `Scadenza_anno`) 
VALUES ('3957104299017492', '20099', 'Alessandro Lo Bosco', '321', '3', '2025'), 
('1957302967291048', '20098', 'Mario Rossi', '457', '12', '2024'),
 ('0472928461048592', '20100', 'Pietro Gialli', '888', '4', '2026');