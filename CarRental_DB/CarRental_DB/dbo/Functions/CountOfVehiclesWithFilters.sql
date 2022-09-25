-- =============================================
-- Author:		Nino Omic
-- Create date: 23.09.2022
-- Description:	Returns count of filtered vehicles
-- =============================================
CREATE FUNCTION [dbo].[CountOfVehiclesWithFilters]
(
	@VehicleName nvarchar(200), @VehicleManufacturerId nvarchar(200), @VehicleTypeId int
)
RETURNS int
AS
BEGIN
	DECLARE @CountOfVehicles INT = 0

	SET @CountOfVehicles = (SELECT COUNT(VehicleID)
			FROM Vehicle
			WHERE (VehicleName = @VehicleName OR @VehicleName IS NULL)
				AND (VehicleManufacturerID = @VehicleManufacturerId OR @VehicleManufacturerId IS NULL)
				AND (VehicleTypeID = @VehicleTypeId OR @VehicleTypeId IS NULL)
		)

	RETURN @CountOfVehicles

END