/*Vista per il prezzo scontato*/

CREATE VIEW CalcolaPrezzoScontato (PrezzoScontato, CodArticolo) AS
SELECT ROUND((prezzo.Prezzo-((prezzo.Prezzo*prezzo.Sconto)/100)), 2), articolo.Cod_articolo
FROM prezzo, articolo
WHERE prezzo.Cod_articolo = articolo.Cod_articolo;

/*VIEWS per vedere il PrezzoScontato*quantita */
CREATE VIEW PrezzoScontatoxQuantita (Id_acquirente, Cod_articolo, PrezzoQuantita, acquistato) AS
SELECT acquisto.Id_acquirente  , acquisto.Cod_articolo ,(calcolaprezzoscontato.PrezzoScontato *acquisto.Quantita) AS Costo, acquisto.Acquistato
FROM acquisto, calcolaprezzoscontato
WHERE calcolaprezzoscontato.CodArticolo = acquisto.Cod_articolo;

/*media stelle per ogni articolo*/
CREATE VIEW MediaStelle (Cod_articolo, media) AS
SELECT articolo.Cod_articolo, ROUND(AVG(recensioni.Stelle),2 )AS Media_Stelle
FROM articolo, recensioni
WHERE articolo.Cod_articolo = recensioni.Cod_articolo
GROUP BY articolo.Cod_articolo;

/*1)*/
/*Tutte le recensioni di un articolo che ha un prezzo compreso tra 5 euro e 30 euro*/
SELECT articolo.Nome, recensioni.Cod_recensioni, recensioni.Stelle, recensioni.Commento, calcolaprezzoscontato.PrezzoScontato
FROM recensioni, articolo, prezzo, calcolaprezzoscontato
WHERE recensioni.Cod_articolo = articolo.Cod_articolo AND prezzo.Cod_articolo = articolo.Cod_articolo AND
calcolaprezzoscontato.CodArticolo = articolo.Cod_articolo AND
calcolaprezzoscontato.PrezzoScontato >=5 AND calcolaprezzoscontato.PrezzoScontato<=30

/*2)*/
/*Media delle stelle di un articolo */
/*La faccio deventare una vista*//*
SELECT articolo.Cod_articolo, ROUND(AVG(recensioni.Stelle),2 )AS Media_Stelle
FROM articolo, recensioni
WHERE articolo.Cod_articolo = recensioni.Cod_articolo
GROUP BY articolo.Cod_articolo*/

/*3)*/
/*Vedere tutti gli articoli per categoria*/
SELECT categoria.Nome, articolo.Nome
FROM categoria, articolo
WHERE categoria.Id_categoria = articolo.Id_categoria

/*4)*/
/*Query per avere il costo totale del carrello di un acquirente*/
SELECT acquirente.Nome, SUM(prezzoscontatoxquantita.PrezzoQuantita) AS CostoToTCarrello
FROM acquisto, acquirente, prezzoscontatoxquantita
WHERE acquirente.Id_acquirente = acquisto.Id_acquirente AND prezzoscontatoxquantita.acquistato = 0 
AND acquisto.Acquistato = 0 AND acquisto.Cod_articolo = prezzoscontatoxquantita.Cod_articolo
GROUP BY acquirente.Nome

/*5)*/
/*Query per controllare se l'acquirente ha almeno una carta*/
/*primo modo*/
SELECT acquirente.Id_acquirente, acquirente.Nome, acquirente.Cognome, CASE WHEN acquirente.Id_acquirente IN (SELECT carta.Id_acquirente FROM carta)
       THEN 'SI' 
       ELSE 'NO'
  END AS 'Ha la carta?'  
FROM acquirente
/*secondo modo*/
SELECT acquirente.Id_acquirente FROM acquirente WHERE acquirente.Id_acquirente  NOT IN (SELECT carta.Id_acquirente FROM carta)

/*6)*/
/*Per ogni negozio vedere tutti gli articoli con ognuno il proprio prezzo( e sconto)*/
SELECT negozio.Cod_negozio, negozio.Nome, articolo.Cod_articolo, articolo.Nome, calcolaprezzoscontato.PrezzoScontato
FROM negozio, articolo, calcolaprezzoscontato
WHERE negozio.Cod_negozio = articolo.Cod_negozio AND articolo.Cod_articolo = calcolaprezzoscontato.CodArticolo

/*7*/
/*Vedere tutti gli ordini per ogni acquirente*/
SELECT acquirente.Nome, acquirente.Cognome, articolo.Nome, prezzoscontatoxquantita.PrezzoQuantita , acquisto.Quantita
FROM articolo, acquisto, prezzoscontatoxquantita, acquirente
WHERE articolo.Cod_articolo = acquisto.Cod_articolo AND acquisto.Id_acquirente = acquirente.Id_acquirente AND
prezzoscontatoxquantita.Cod_articolo = acquisto.Cod_articolo AND acquisto.Acquistato = 1
GROUP BY acquirente.Nome, acquirente.Cognome

/*8*/
/*Vedere tutti gli elementi del carrello per ogni acquirente (vista)*/
SELECT acquirente.Nome, acquirente.Cognome, articolo.Nome, prezzoscontatoxquantita.PrezzoQuantita , acquisto.Quantita
FROM articolo, acquisto, prezzoscontatoxquantita, acquirente
WHERE articolo.Cod_articolo = acquisto.Cod_articolo AND acquisto.Id_acquirente = acquirente.Id_acquirente AND
prezzoscontatoxquantita.Cod_articolo = acquisto.Cod_articolo AND acquisto.Acquistato = 0

/*9*/
/*Vedere tutti gli indirizzi dei magazzini*/
SELECT magazzino.Cod_magazzino, indirizzo.Nome, citta.Nome, regione.Nome, nazione.Nome
FROM magazzino, indirizzo, citta, regione, nazione
WHERE magazzino.Id_indirizzo = indirizzo.Id_indirizzo AND indirizzo.Id_citta = citta.Id_citta AND
citta.Id_regione = regione.Id_regione AND regione.Id_nazione = nazione.Id_nazione 

/*10)*/
/*Articoli che hanno come media 4 stelle in su*/
SELECT mediastelle.Cod_articolo, mediastelle.media
FROM mediastelle, articolo
WHERE articolo.Cod_articolo = mediastelle.Cod_articolo AND mediastelle.media >= 4

/*11)*/
/*Rimozione di uno specifico acquirente*/
DELETE FROM carta WHERE Id_acquirente= '20098';
DELETE FROM recensioni WHERE Id_acquirente ='20098';
DELETE FROM acquisto WHERE Id_acquirente = '20098';
DELETE FROM acquirente WHERE Id_acquirente = '20098'; 