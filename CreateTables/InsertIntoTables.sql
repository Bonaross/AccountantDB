use AccountantDB;

INSERT INTO LAWYERS
(ID, NAME, SURNAME, SALARY, HIREDATE)
VALUES
(NEXT VALUE FOR lawyers_id_seq, 'Bo¿ena', 'Pula', 9000, GETDATE()),
(NEXT VALUE FOR lawyers_id_seq, 'Ernest', 'Budka', 5000, GETDATE()),
(NEXT VALUE FOR lawyers_id_seq, 'Grzegorz', 'Orzechowski', 13000, GETDATE()),
(NEXT VALUE FOR lawyers_id_seq, 'Urszula', 'Wysocka', 10000, GETDATE());




INSERT INTO INVOICES
(ID_INVOICES, INV_NUMBER, INV_OWNER, INV_NET_VAL, INV_VAT, INV_DATE, INV_TYPE, INV_STATUS)
VALUES
(NEXT VALUE FOR dbo.invoices_id_seq, '1234', NULL, 788.00, 23.00, GETDATE(), 'COST', 'PENDING');

SELECT * FROM INVOICES;
SELECT * FROM INVOICES_ARCH;





