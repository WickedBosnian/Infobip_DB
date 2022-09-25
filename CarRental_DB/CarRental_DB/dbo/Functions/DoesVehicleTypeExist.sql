-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns true or false depending if the vehicle type exists
-- =============================================
CREATE FUNCTION [dbo].[DoesVehicleTypeExist]
(
	@TypeId int
)
RETURNS bit
AS
BEGIN
	DECLARE @VehicleTypeExists bit = 0

	IF(SELECT COUNT(*) FROM VehicleType WHERE VehicleTypeID = @TypeId) >= 1
		SET @VehicleTypeExists = 1

	RETURN @VehicleTypeExists

END