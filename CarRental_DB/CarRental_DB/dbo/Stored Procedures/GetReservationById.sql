-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Gets reservation by id
-- =============================================
CREATE PROCEDURE [dbo].[GetReservationById]
	@ReservationId int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 *
	FROM Reservation
	WHERE ReservationID = @ReservationId
END