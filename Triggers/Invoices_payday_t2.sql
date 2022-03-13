use AccountantDB;
go

CREATE OR ALTER TRIGGER invoices_payday_t2
ON dbo.invoices
AFTER INSERT, UPDATE
AS
BEGIN
DECLARE @curr_date_t2 DATE,
		@inv_number_temp NVARCHAR(50);
	SET NOCOUNT ON;
	SELECT @curr_date_t2 = (SELECT INV_DATE FROM INVOICES 
						WHERE ID_INVOICES = (SELECT current_value FROM sys.sequences
										WHERE [name] = 'invoices_id_seq'));
	SELECT @inv_number_temp = (SELECT INV_NUMBER FROM INVOICES 
						WHERE ID_INVOICES = (SELECT current_value FROM sys.sequences
										WHERE [name] = 'invoices_id_seq'));
	EXEC invoices_payday_p2 @curr_date_t2, @inv_number_temp ;
END;
go