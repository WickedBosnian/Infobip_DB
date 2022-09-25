-- =============================================
-- Author:		Nino Omic
-- Create date: 24.09.2022
-- Description:	Returns number of records from Reservation table
-- =============================================
CREATE FUNCTION CountOfReservations()
RETURNS int
AS
BEGIN
	DECLARE @CountOfReservations INT
	SET @CountOfReservations = (SELECT COUNT(ReservationID) FROM Reservation)
	RETURN @CountOfReservations
END