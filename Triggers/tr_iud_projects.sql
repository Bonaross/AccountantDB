USE AccountantDB;
go

CREATE OR ALTER TRIGGER tr_iud_projects
ON dbo.projects
AFTER INSERT, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	
	IF EXISTS (SELECT 0 FROM inserted)
		INSERT INTO projects_ARCH
		(
			ID_projects_ARCH	
			,NEW_PROJ_NAME		
			,NEW_PROJ_MGR		
			,NEW_PROJ_BUDGET
			,NEW_PROJ_CLIENT_ID
			,NEW_PROJ_START
			,NEW_PROJ_END
			,OLD_PROJ_NAME	
			,OLD_PROJ_MGR
			,OLD_PROJ_BUDGET
			,OLD_PROJ_CLIENT_ID
			,OLD_PROJ_START
			,OLD_PROJ_END
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.projects_arch_id_seq
			,	i.PROJ_NAME		
			,	i.PROJ_MGR		
			,	i.PROJ_BUDGET
			,	i.PROJ_CLIENT_ID
			,	i.PROJ_START
			,	i.PROJ_END
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
		INSERT INTO projects_ARCH
		(
			ID_projects_ARCH	
			,NEW_PROJ_NAME		
			,NEW_PROJ_MGR		
			,NEW_PROJ_BUDGET
			,NEW_PROJ_CLIENT_ID
			,NEW_PROJ_START
			,NEW_PROJ_END
			,OLD_PROJ_NAME	
			,OLD_PROJ_MGR
			,OLD_PROJ_BUDGET
			,OLD_PROJ_CLIENT_ID
			,OLD_PROJ_START
			,OLD_PROJ_END
			,CHANGE_TIME		
			,OPERATION_TYPE	
		)
		SELECT	
			NEXT VALUE FOR dbo.projects_arch_id_seq
			,	NULL
			,	NULL
			,	NULL
			,	NULL
			,	NULL
			,	NULL
			,	d.PROJ_NAME		
			,	d.PROJ_MGR		
			,	d.PROJ_BUDGET
			,	d.PROJ_CLIENT_ID
			,	d.PROJ_START
			,	d.PROJ_END
			,	SYSDATETIME()
			,	'DELETE'
		FROM deleted d
END;
go