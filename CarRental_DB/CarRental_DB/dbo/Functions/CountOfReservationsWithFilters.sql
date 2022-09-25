-- =============================================
-- Author:		Nino Omic
-- Create date: 24.09.2022
-- Description:	Returns number of records from table Reservation based on input parameters
-- =============================================
CREATE FUNCTION [dbo].[CountOfReservationsWithFilters] 
(
	@DateFrom datetime, @DateTo datetime, @ClientId int, @VehicleId int, @Active bit
)
RETURNS INT
AS
BEGIN
	DECLARE @CountOfReservations INT = 0

	SET @CountOfReservations = (SELECT COUNT(ReservationID)
		FROM Reservation
		WHERE (ReservationDateFrom >= @DateFrom OR @DateFrom IS NULL)
			AND (ReservationDateTo <= @DateTo OR @DateTo IS NULL)
			AND (ClientID = @ClientId OR @ClientId IS NULL)
			AND (VehicleID = @VehicleId OR @VehicleId IS NULL)
			AND (Active = @Active OR @Active IS NULL))

	RETURN @CountOfReservations
END