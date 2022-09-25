-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns a records from VehicleManufacturer table based on id
-- =============================================
CREATE PROCEDURE [dbo].[GetVehicleManufacturerById]
	@VehicleManufacturerId int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT TOP 1 *
	FROM VehicleManufacturer
	WHERE VehicleManufacturerID = @VehicleManufacturerId
END