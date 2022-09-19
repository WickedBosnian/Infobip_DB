-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Gets reservation by id
-- =============================================
CREATE PROCEDURE GetReservationById
	@ReservationId int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Reservation
	WHERE ReservationID = @ReservationId
END