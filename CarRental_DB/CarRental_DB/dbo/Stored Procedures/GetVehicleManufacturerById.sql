-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns a records from VehicleManufacturer table based on id
-- =============================================
CREATE PROCEDURE GetVehicleManufacturerById
	@VehicleManufacturerId int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT *
	FROM VehicleManufacturer
	WHERE VehicleManufacturerID = @VehicleManufacturerId
END