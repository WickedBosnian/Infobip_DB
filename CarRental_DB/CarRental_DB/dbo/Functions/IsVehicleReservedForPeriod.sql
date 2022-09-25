-- =============================================
-- Author:		Nino Omic
-- Create date: 2022-09-19
-- Description:	Returns true if vehicle is reserved for requested period, otherwise returns false
-- =============================================
CREATE FUNCTION [dbo].[IsVehicleReservedForPeriod]
(
	@VehicleId int, @From datetime, @To datetime
)
RETURNS bit
AS
BEGIN
	DECLARE @IsReserved bit = 0

	IF(SELECT COUNT(*) 
		FROM Reservation AS R 
		JOIN Vehicle AS V ON V.VehicleID = R.VehicleID 
		WHERE R.Active = 1 
			AND R.VehicleID = @VehicleId
			AND ((R.ReservationDateFrom <= @To) AND (R.ReservationDateTo >= @From))
			) >= 1
		SET @IsReserved = 1

	RETURN @IsReserved

END