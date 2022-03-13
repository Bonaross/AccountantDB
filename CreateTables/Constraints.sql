use AccountantDB;
go

-- CONSTRAINTS -- 

---INVOICES---

ALTER TABLE INVOICES
ADD CONSTRAINT FK_INV_OWNER_ID FOREIGN KEY (INV_OWNER) REFERENCES LAWYERS(ID);
ALTER TABLE INVOICES
ADD CONSTRAINT FK_INV_PROJECT_ID FOREIGN KEY (INV_PROJ_ID) REFERENCES PROJECTS(ID_PROJECTS);
go

---DEPARTMENTS---

ALTER TABLE DEPARTMENTS
ADD CONSTRAINT FK_DEPT_MGR_ID FOREIGN KEY (DEPT_MGR) REFERENCES LAWYERS(ID);
go

---PROJECTS---

ALTER TABLE PROJECTS
ADD CONSTRAINT FK_PROJ_MGR_ID FOREIGN KEY (PROJ_MGR) REFERENCES LAWYERS(ID);
ALTER TABLE PROJECTS
ADD CONSTRAINT FK_PROJ_DEPT_ID FOREIGN KEY (PROJ_DEPT_ID) REFERENCES DEPARTMENTS(ID_DEPARTMENTS);
ALTER TABLE PROJECTS
ADD CONSTRAINT FK_PROJ_CLIENT_ID FOREIGN KEY (PROJ_CLIENT_ID) REFERENCES CLIENTS(ID_CLIENTS);
go


ALTER TABLE INVOICES
ADD CONSTRAINT unique_inv_number UNIQUE (INV_NUMBER);