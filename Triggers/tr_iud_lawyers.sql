use AccountantDB;
go

CREATE OR ALTER TRIGGER tr_iud_lawyers
ON dbo.LAWYERS
AFTER INSERT, UPDATE, DELETE
AS
DECLARE
		@OLD_NAME		NVARCHAR(50),
		@OLD_SURNAME	NVARCHAR(50),
		@OLD_SALARY		INT,
		@OLD_HIREDATE	DATE
		SELECT @OLD_NAME = d.NAME FROM deleted d;
		SELECT @OLD_SURNAME = d.SURNAME FROM deleted d;
		SELECT @OLD_SALARY = d.SALARY FROM deleted d;
		SELECT @OLD_HIREDATE = d.HIREDATE FROM deleted d;
BEGIN
	SET NOCOUNT ON;
	
	IF EXISTS (SELECT 0 FROM inserted)
		INSERT INTO LAWYERS_ARCH
		(
			ID_LAWYERS_ARCH	
			,NEW_NAME		
			,NEW_SURNAME		
			,NEW_SALARY		
			,NEW_HIREDATE	
			,OLD_NAME		
			,OLD_SURNAME		
			,OLD_SALARY		
			,OLD_HIREDATE	
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.lawyers_arch_id_seq
			,	i.NAME
			,	i.SURNAME
			,	i.SALARY
			,	i.HIREDATE
			,	NULL 
			,	NULL
			,	NULL
			,	NULL
			,	SYSDATETIME()
			,	'INSERT'
		FROM inserted i
	ELSE 
		IF EXISTS (SELECT 0 FROM deleted)
		INSERT INTO LAWYERS_ARCH
		(
			ID_LAWYERS_ARCH	
			,NEW_NAME		
			,NEW_SURNAME		
			,NEW_SALARY		
			,NEW_HIREDATE	
			,OLD_NAME		
			,OLD_SURNAME		
			,OLD_SALARY		
			,OLD_HIREDATE	
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.lawyers_arch_id_seq
			,	NULL
			,	NULL
			,	NULL
			,	NULL
			,	d.NAME
			,	d.SURNAME
			,	d.SALARY
			,	d.HIREDATE
			,	SYSDATETIME()
			,	'DELETE'
		FROM deleted d
	ELSE
		INSERT INTO LAWYERS_ARCH
		(
			ID_LAWYERS_ARCH	
			,NEW_NAME		
			,NEW_SURNAME		
			,NEW_SALARY		
			,NEW_HIREDATE	
			,OLD_NAME		
			,OLD_SURNAME		
			,OLD_SALARY		
			,OLD_HIREDATE	
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.lawyers_arch_id_seq
			,	i.NAME
			,	i.SURNAME
			,	i.SALARY
			,	i.HIREDATE
			,	@OLD_NAME
			,	@OLD_SURNAME
			,	@OLD_SALARY
			,	@OLD_HIREDATE
			,	SYSDATETIME()
			,	'UPDATE'
		FROM inserted i	
END;
go