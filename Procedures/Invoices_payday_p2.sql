use AccountantDB;
go

CREATE OR ALTER PROCEDURE invoices_payday_p2
@curr_date DATE,
@inv_number_temp NVARCHAR(50)
AS
BEGIN
	IF @curr_date IS NOT NULL
		UPDATE dbo.INVOICES
		SET invoices.INV_PAYDAY = DATEADD(day,30,@curr_date)
			WHERE invoices.INV_NUMBER = @inv_number_temp
	ELSE
		UPDATE dbo.INVOICES
		SET invoices.INV_PAYDAY = NULL
			WHERE invoices.INV_NUMBER = @inv_number_temp
END;
go