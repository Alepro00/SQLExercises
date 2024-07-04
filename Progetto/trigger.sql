
/*Trigger per gestire */
CREATE TRIGGER `TriggerCarrello` AFTER UPDATE ON `acquisto` FOR EACH ROW
UPDATE Articolo art
INNER JOIN Acquisto acq
ON art.Cod_articolo=acq.Cod_articolo
SET art.Quantita = art.Quantita - acq.Quantita
WHERE acq.Acquistato=1;
