-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Searches for reservations by parameters
-- =============================================
CREATE PROCEDURE [dbo].[SearchReservations]
	@DateFrom datetime, @DateTo datetime, @ClientId int, @VehicleId int, @Active bit
		,@PageNumber INT = 1, @RowsPerPage INT = 10
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Reservation
	WHERE (CAST(ReservationDateFrom AS date) >= @DateFrom OR @DateFrom IS NULL)
		AND (CAST(ReservationDateTo AS date) <= @DateTo OR @DateTo IS NULL)
		AND (ClientID = @ClientId OR @ClientId IS NULL)
		AND (VehicleID = @VehicleId OR @VehicleId IS NULL)
		AND (Active = @Active OR @Active IS NULL)
	ORDER BY ReservationID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
END