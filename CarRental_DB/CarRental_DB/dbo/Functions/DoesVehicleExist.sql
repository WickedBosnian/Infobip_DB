-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns true or false depending if the vehicle exists
-- =============================================
CREATE FUNCTION [dbo].[DoesVehicleExist]
(
	@VehicleId int
)
RETURNS bit
AS
BEGIN
	DECLARE @VehicleExists bit = 0

	IF(SELECT COUNT(*) FROM Vehicle WHERE VehicleID = @VehicleId) >= 1
		SET @VehicleExists = 1

	RETURN @VehicleExists

END