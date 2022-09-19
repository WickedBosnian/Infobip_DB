-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns all records from VehicleManufacturer table
-- =============================================
CREATE PROCEDURE GetAllVehicleManufacturers	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT *
	FROM VehicleManufacturer
END