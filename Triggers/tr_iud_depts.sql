use AccountantDB;
go

CREATE OR ALTER TRIGGER tr_iud_depts
ON dbo.departments
AFTER INSERT, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 0 FROM inserted)
		INSERT INTO DEPARTMENTS_ARCH
		(
			ID_DEPARTMENTS_ARCH	
			,NEW_DEPT_NAME		
			,NEW_DEPT_MGR		
			,OLD_DEPT_NAME		
			,OLD_DEPT_MGR		
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.dept_arch_id_seq
			,	i.DEPT_NAME		
			,	i.DEPT_MGR		
			,	NULL 
			,	NULL
			,	SYSDATETIME()
			,	'INSERT'
		FROM inserted i
	ELSE 
		IF EXISTS (SELECT 0 FROM deleted)
		INSERT INTO DEPARTMENTS_ARCH
		(
			ID_DEPARTMENTS_ARCH	
			,NEW_DEPT_NAME		
			,NEW_DEPT_MGR		
			,OLD_DEPT_NAME		
			,OLD_DEPT_MGR		
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.dept_arch_id_seq
			,	NULL
			,	NULL
			,	d.DEPT_NAME		
			,	d.DEPT_MGR		
			,	SYSDATETIME()
			,	'DELETE'
		FROM deleted d
END;
go