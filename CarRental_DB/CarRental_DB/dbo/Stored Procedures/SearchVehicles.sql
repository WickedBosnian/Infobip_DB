-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Searches for vehicles by parameters
-- =============================================
CREATE PROCEDURE SearchVehicles
	@VehicleName nvarchar(200), @VehicleManufacturerId int, @VehicleTypeId int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Vehicle
	WHERE (VehicleName = @VehicleName OR @VehicleName IS NULL)
		AND (VehicleManufacturerId = @VehicleManufacturerId OR @VehicleManufacturerId IS NULL)
		AND (VehicleTypeId = @VehicleTypeId OR @VehicleTypeId IS NULL)
END