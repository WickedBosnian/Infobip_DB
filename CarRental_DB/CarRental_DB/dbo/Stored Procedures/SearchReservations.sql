-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Searches for reservations by parameters
-- =============================================
CREATE PROCEDURE [dbo].[SearchReservations]
	@DateFrom datetime, @DateTo datetime, @ClientId int, @VehicleId int, @Active bit
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Reservation
	WHERE (ReservationDateFrom >= @DateFrom OR @DateFrom IS NULL)
		AND (ReservationDateTo <= @DateTo OR @DateTo IS NULL)
		AND (ClientID = @ClientId OR @ClientId IS NULL)
		AND (VehicleID = @VehicleId OR @VehicleId IS NULL)
		AND (Active = @Active OR @Active IS NULL)
END