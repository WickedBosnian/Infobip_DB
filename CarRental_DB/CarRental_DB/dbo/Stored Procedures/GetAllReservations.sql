-- =============================================
-- Author:		Nino Omic
-- Create date: 17.09.2022
-- Description:	Returns all records from table Reservation
-- =============================================
CREATE PROCEDURE [dbo].[GetAllReservations]
AS
SELECT *
FROM Reservation
ORDER BY ReservationID DESC