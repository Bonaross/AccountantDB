use AccountantDB;
go

CREATE OR ALTER TRIGGER tr_iud_clients
ON dbo.clients
AFTER INSERT, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 0 FROM inserted)
		INSERT INTO CLIENTS_ARCH
		(
			ID_CLIENTS_ARCH	
			,NEW_CLIENT_NAME	
			,OLD_CLIENT_NAME				
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.clients_arch_id_seq
			,	i.CLIENT_NAME	
			,	NULL
			,	SYSDATETIME()
			,	'INSERT'
		FROM inserted i
	ELSE 
		IF EXISTS (SELECT 0 FROM deleted)
		INSERT INTO CLIENTS_ARCH
		(
			ID_CLIENTS_ARCH	
			,NEW_CLIENT_NAME	
			,OLD_CLIENT_NAME				
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.clients_arch_id_seq
			,	NULL
			,	d.CLIENT_NAME		
			,	SYSDATETIME()
			,	'DELETE'
		FROM deleted d
END;
go