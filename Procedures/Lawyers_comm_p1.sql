USE AccountantDB;
go

CREATE OR ALTER PROCEDURE lawyers_comm_p1
@curr_comm DECIMAL(10,2),
@lawyer_id_comm INT,
@curr_net_val DECIMAL (10,2),
@curr_vat_val DECIMAL (10,2)
AS
BEGIN 
	SELECT @curr_comm = (SELECT COMM FROM LAWYERS WHERE LAWYERS.ID = @lawyer_id_comm)
	IF @curr_net_val IS NOT NULL
		UPDATE dbo.LAWYERS
		SET COMM = @curr_comm + (@curr_net_val * (1+@curr_vat_val/100) * 0.25);
	ELSE
		PRINT 'Invoice is not payed. Commision did not change';
END;
go