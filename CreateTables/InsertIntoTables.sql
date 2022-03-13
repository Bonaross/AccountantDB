use AccountantDB;
go

INSERT INTO LAWYERS
(ID, NAME, SURNAME, SALARY, HIREDATE)
VALUES
(NEXT VALUE FOR lawyers_id_seq, 'Bo¿ena', 'Pula', 9000, GETDATE()),
(NEXT VALUE FOR lawyers_id_seq, 'Ernest', 'Budka', 5000, GETDATE()),
(NEXT VALUE FOR lawyers_id_seq, 'Grzegorz', 'Orzechowski', 13000, GETDATE()),
(NEXT VALUE FOR lawyers_id_seq, 'Urszula', 'Wysocka', 10000, GETDATE());
go

INSERT INTO INVOICES
(ID_INVOICES, INV_NUMBER, INV_OWNER, INV_NET_VAL, INV_VAT, INV_DATE, INV_TYPE, INV_STATUS)
VALUES
(NEXT VALUE FOR dbo.invoices_id_seq, '1', 2, 788.00, 23.00, GETDATE(), 'COST', 'PENDING'),
(NEXT VALUE FOR dbo.invoices_id_seq, '2', 3, 14333.00, 23.00, GETDATE(), 'COST', 'PENDING'),
(NEXT VALUE FOR dbo.invoices_id_seq, '3', 3, 1233.98, 23.00, GETDATE(), 'INCOME', 'PENDING'),
(NEXT VALUE FOR dbo.invoices_id_seq, '4', 1, 1004.04, 23.00, GETDATE(), 'COST', 'PAYED');
go

INSERT INTO DEPARTMENTS
(ID_DEPARTMENTS, DEPT_NAME, DEPT_MGR)
VALUES
(NEXT VALUE FOR dbo.dept_id_seq, 'Environment', (SELECT LAWYERS.ID FROM dbo.LAWYERS WHERE LAWYERS.NAME = 'Ernest' AND LAWYERS.SURNAME = 'Budka')),
(NEXT VALUE FOR dbo.dept_id_seq, 'Civil Law', (SELECT LAWYERS.ID FROM dbo.LAWYERS WHERE (LAWYERS.NAME = 'Grzegorz' AND LAWYERS.SURNAME = 'Orzechowski'))),
(NEXT VALUE FOR dbo.dept_id_seq, 'Insurance', (SELECT LAWYERS.ID FROM dbo.LAWYERS WHERE (LAWYERS.NAME = 'Urszula' AND LAWYERS.SURNAME = 'Wysocka')));
go

INSERT INTO CLIENTS
(ID_CLIENTS,CLIENT_NAME)
VALUES
(NEXT VALUE FOR dbo.clients_id_seq, 'PETA' ),
(NEXT VALUE FOR dbo.clients_id_seq, 'Adidas' ),
(NEXT VALUE FOR dbo.clients_id_seq, 'Nike' ),
(NEXT VALUE FOR dbo.clients_id_seq, 'Disney' );
go

INSERT INTO PROJECTS
(ID_PROJECTS,PROJ_NAME, PROJ_MGR, PROJ_BUDGET, PROJ_CLIENT_ID, PROJ_DEPT_ID, PROJ_START, PROJ_END)
VALUES
(NEXT VALUE FOR dbo.projects_id_seq, 'Water Pollution', 1, 130000, 1,1, GETDATE(), DATEADD(year,1,GETDATE())),
(NEXT VALUE FOR dbo.projects_id_seq, 'Adidas Mobbing', 2, 80000, 2,2, GETDATE(), DATEADD(MONTH,7,GETDATE())),
(NEXT VALUE FOR dbo.projects_id_seq, 'Nike Insurence',3, 1000000, 3,3, '2022-01-02', DATEADD(MONTH, 3, '2022-01-02')),
(NEXT VALUE FOR dbo.projects_id_seq, 'Disney Dismissal', 2, 150000, 4,2, GETDATE(), DATEADD(MONTH,2,GETDATE()));
go