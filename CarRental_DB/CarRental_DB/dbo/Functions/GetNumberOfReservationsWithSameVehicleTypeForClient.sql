-- =============================================
-- Author:		Nino Omic
-- Create date: 2022-09-19
-- Description:	Returns amount of active transactions for a client that have a vehicle of the same type
-- =============================================
CREATE FUNCTION [dbo].[GetNumberOfReservationsWithSameVehicleTypeForClient]
(
	@ClientId int, @VehicleId int, @From datetime, @To datetime
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @NumberOfReservations int

	-- Add the T-SQL statements to compute the return value here
	SET @NumberOfReservations = (SELECT COUNT(*)
				FROM Vehicle AS VV
				WHERE VV.VehicleID = @VehicleId
					AND VV.VehicleTypeID IN
					(
						SELECT V.VehicleTypeID
							FROM Reservation AS R
							JOIN Vehicle AS V ON V.VehicleID = R.VehicleID
							WHERE R.ClientID = @ClientId
							AND R.Active = 1
							AND ((R.ReservationDateFrom <= @To) AND (R.ReservationDateTo >= @From))
					))

	RETURN @NumberOfReservations

END