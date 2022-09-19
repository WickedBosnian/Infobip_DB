-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns true or false depending if the vehicle manufacturer exists
-- =============================================
CREATE FUNCTION DoesManufacturerExist
(
	@ManufacturerId int
)
RETURNS bit
AS
BEGIN
	DECLARE @MnufacturerExists bit = 0

	IF(SELECT COUNT(*) FROM VehicleManufacturer WHERE VehicleManufacturerID = @ManufacturerId) >= 1
		SET @MnufacturerExists = 1

	RETURN @MnufacturerExists

END