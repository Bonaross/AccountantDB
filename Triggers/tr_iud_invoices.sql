use AccountantDB;
go

CREATE OR ALTER TRIGGER tr_iud_invoices
ON dbo.invoices
AFTER INSERT, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 0 FROM inserted)
		INSERT INTO INVOICES_ARCH
		(
				ID_INVOICES_ARCH	
			,	NEW_INV_NUMBER		
			,	NEW_INV_OWNER		
			,	NEW_INV_NET_VAL		
			,	NEW_INV_VAT			
			,	NEW_INV_BRU_VAL		
			,	NEW_INV_DATE		
			,	NEW_INV_PAYDAY		
			,	NEW_INV_PROJ_ID		
			,	NEW_INV_TYPE		
			,	NEW_INV_CLIENT_ID	
			,	NEW_INV_STATUS		
			,	OLD_INV_NUMBER		
			,	OLD_INV_OWNER			
			,	OLD_INV_NET_VAL		
			,	OLD_INV_VAT			
			,	OLD_INV_BRU_VAL		
			,	OLD_INV_DATE	
			,	OLD_INV_PAYDAY		
			,	OLD_INV_PROJ_ID		
			,	OLD_INV_TYPE		
			,	OLD_INV_CLIENT_ID	
			,	OLD_INV_STATUS		
			,	CHANGE_TIME			
			,	OPERATION_TYPE		
		)
		SELECT	
			NEXT VALUE FOR dbo.invoices_arch_id_seq
			,	i.INV_NUMBER		
			,	i.INV_OWNER		
			,	i.INV_NET_VAL		
			,	i.INV_VAT			
			,	i.INV_BRU_VAL		
			,	i.INV_DATE		
			,	i.INV_PAYDAY		
			,	i.INV_PROJ_ID		
			,	i.INV_TYPE		
			,	i.INV_CLIENT_ID	
			,	i.INV_STATUS		
			,	NULL
			,	NULL	
			,	NULL	
			,	NULL			
			,	NULL
			,	NULL
			,	NULL	
			,	NULL	
			,	NULL	
			,	NULL
			,	NULL	
			,	SYSDATETIME()
			,	'INSERT'
		FROM inserted i
	ELSE 
		IF EXISTS (SELECT 0 FROM deleted)
		INSERT INTO INVOICES_ARCH
		(
			ID_INVOICES_ARCH	
			,	NEW_INV_NUMBER		
			,	NEW_INV_OWNER			
			,	NEW_INV_NET_VAL		
			,	NEW_INV_VAT			
			,	NEW_INV_BRU_VAL		
			,	NEW_INV_DATE		
			,	NEW_INV_PAYDAY		
			,	NEW_INV_PROJ_ID		
			,	NEW_INV_TYPE		
			,	NEW_INV_CLIENT_ID	
			,	NEW_INV_STATUS		
			,	OLD_INV_NUMBER		
			,	OLD_INV_OWNER			
			,	OLD_INV_NET_VAL		
			,	OLD_INV_VAT			
			,	OLD_INV_BRU_VAL		
			,	OLD_INV_DATE	
			,	OLD_INV_PAYDAY		
			,	OLD_INV_PROJ_ID		
			,	OLD_INV_TYPE		
			,	OLD_INV_CLIENT_ID	
			,	OLD_INV_STATUS		
			,	CHANGE_TIME			
			,	OPERATION_TYPE		
		)
		SELECT	
			NEXT VALUE FOR dbo.depts_arch_id_seq
			ID_INVOICES_ARCH	
			,	NULL		
			,	NULL		
			,	NULL		
			,	NULL		
			,	NULL		
			,	NULL		
			,	NULL		
			,	NULL		
			,	NULL		
			,	NULL	
			,	NULL		
			,	d.INV_NUMBER		
			,	d.INV_OWNER			
			,	d.INV_NET_VAL		
			,	d.INV_VAT			
			,	d.INV_BRU_VAL		
			,	d.INV_DATE	
			,	d.INV_PAYDAY		
			,	d.INV_PROJ_ID		
			,	d.INV_TYPE		
			,	d.INV_CLIENT_ID	
			,	d.INV_STATUS		
			,	SYSDATETIME()
			,	'DELETE'		
		FROM deleted d;
END;
go