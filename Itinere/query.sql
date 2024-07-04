/*Trovare codici e nomi degli acquedotti che riforniscono la città di Roma*/

SELECT Codice, NomeAcq
FROM Acquedotti, Citta, Fornitura
WHERE Codice=Acquedotto AND ID=Fornitura.Citta AND NomeCitta='Roma';



/*Trovare i nomi delle città per cui nessuno degli acquedotti presso cui si rifornisce ha portata
relativamente alla fornitura di quella città superiore a 400 litri al secondo. utilizzare not exist.*/


/*Trovare il nome dell'acquedotto che ha portata minima verso una città che rifornisce.*/
SELECT NomeAcq, MIN(Portata)
FROM Acquedotti, Citta, Fornitura
WHERE Codice=Acquedotto AND ID=Fornitura.Citta;


/*Qual è la città più popolosa tra quelle che sono rifornite dall'acquedotto di Scillato*/
SELECT NomeCitta, MAX(Popolazione)
FROM Citta, Fornitura,Acquedotti
WHERE Codice=Acquedotto AND ID=Fornitura.Citta AND NomeAcq='Scillato';


/*Trovare ID delle città rifornite da almeno due acquedotti*/
SELECT Citta, COUNT(Codice) AS NumAcquedotti
FROM Fornitura, Acquedotti
WHERE Codice=Acquedotto
GROUP BY Citta
HAVING NumAcquedotti>1;


/*per ogni acquedotto trovare la portata totale
(intesa come somma delle portate delle forniture dell'acquedotto)*/

/*Mostrare Codice e nome dell'acquedotto con la portata totale massima*/