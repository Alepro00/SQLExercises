
/*Trigger per gestire il carrello*/
CREATE TRIGGER `TriggerCarrello` AFTER UPDATE ON `acquisto` FOR EACH ROW
UPDATE Articolo art
INNER JOIN Acquisto acq
ON art.Cod_articolo=acq.Cod_articolo
SET art.Quantita = art.Quantita - acq.Quantita
WHERE acq.Acquistato=1;


/*Per scrivere una recensione l'articolo deve essere comprato*/








/*
CREATE TRIGGER `TriggerData` AFTER UPDATE ON `acquisto` FOR EACH ROW
UPDATE Acquisto acq
SET acq.Data_acquisto=NOW();
*/


/*Trigger per gestire */
CREATE TRIGGER `TriggerData` AFTER UPDATE ON `acquisto` FOR EACH ROW
UPDATE Acquisto acq
INNER JOIN Articolo art
ON art.Cod_articolo=acq.Cod_articolo
SET Acquisto.Data_acquisto=NOW();







CREATE TRIGGER `TriggerVerificaEsistenzaCarta` BEFORE UPDATE ON `acquisto` FOR EACH ROW
WHEN(NOT EXISTS(SELECT 1
       FROM Carta, Acquirente
       WHERE Carta.Id_acquirente = Acquirente.Id_acquirente))
RAISERROR('Error',10,1)
SIGNAL SQLSTATE '70000'('Le cancellazioni sono permesse solo agli operatori');



CREATE TRIGGER `Trigger` AFTER INSERT ON `acquisto` FOR EACH ROW
UPDATE Articolo art
INNER JOIN Acquisto acq
ON art.Cod_articolo=acq.Cod_articolo
SET art.Quantita = art.Quantita - acq.Quantita;


/*TRIGGER*/

SHOW TRIGGERS; 

CREATE TRIGGER TrigAcquisto 
BEFORE CREATE Acquisto
FOR EACH ROW 
WHEN ((SELECT Id_acquirente AS id_acq_carta
                        FROM Carta
                        WHERE id_acq_carta = Id_acquirente) IS NULL)
SIGNAL SQLSTATE ('Non e stata inserita la carta dell acquirente');



/*TRIGGER*/
CREATE TRIGGER TrigAcquisto 
BEFORE INSERT ON Acquisto
FOR EACH ROW 
WHEN (NOT EXISTS(SELECT Carta.Id_acquirente
       FROM Carta, Acquirente
       WHERE carta.Id_acquirente = Acquirente.Id_acquirente))
SIGNAL SQLSTATE ('Non e stata inserita la carta dell acquirente');



CREATE TRIGGER UpdateQtaResidua
AFTER INSERT ON Acquisto
FOR EACH ROW
UPDATE Articolo
SET Articolo.Quantita = Articolo.Quantita – Acquisto.Quantita
WHERE Articolo.Cod_articolo = Acquisto.Cod_articolo;




/*____________________________________________________________________*/
CREATE TABLE Carta(
Num_carta varchar(16) NOT NULL,
Id_acquirente int DEFAULT 0,
Titolare varchar(60) NOT NULL,
Cvv smallint(3) NOT NULL,
Scadenza datetime NOT NULL,

PRIMARY KEY(Num_carta),
FOREIGN KEY(Id_acquirente) REFERENCES Acquirente(Id_acquirente)
);

/*TRIGGER*/

CREATE TRIGGER TrigAcquisto 
BEFORE INSERT ON Acquisto
FOR EACH ROW 
WHEN ((SELECT Carta.Id_acquirente AS id_acq_carta
                        FROM Carta, Acquirente
                        WHERE id_acq_carta = Acquirente.Id_acquirente) IS NULL)
SIGNAL SQLSTATE ('Non e stata inserita la carta dell acquirente');









CREATE DEFINER=`root`@`localhost` TRIGGER `TriggerAcquisto` AFTER INSERT ON `acquisto` FOR EACH ROW UPDATE articolo
SET articolo.Quantita=articolo.Quantita-acquisto.Quantita


CREATE TRIGGER `TriggerQuantita` AFTER INSERT ON `acquisto` FOR EACH ROW UPDATE articolo
SET articolo.Quantita = articolo.Quantita-acquisto.Quantita
WHERE articolo.Cod_articolo=acquisto.Cod_articolo


/////////////////////////////////////////////////////////////////////


CREATE TRIGGER `Trigger` AFTER INSERT ON `acquisto` FOR EACH ROW
UPDATE Articolo art
INNER JOIN Acquisto acq
ON art.Cod_articolo=acq.Cod_articolo
SET art.Quantita = art.Quantita - acq.Quantita

///////////////////////////////////////////////////////////////////////


CREATE TRIGGER Trigger 
ON acquisto AFTER INSERT, UPDATE
AS 
SELECT articolo.Cod_articolo
FROM Articolo, Acquisto
WHERE articolo.Cod_articolo=acquisto.Cod_articolo





UPDATE articolo
set articolo.Quantita = articolo.Quantita - acquisto.Quantita

INSERT INTO Articolo VALUES('AHDFS122', 1, 10001, 1001, 'Corsair VENGEANCELPX32GB DDR5 3600', 'Slot di ram DDR5 da 32GB per pc fisso',5);