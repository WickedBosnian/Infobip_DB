-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns all records from VehicleManufacturer table
-- =============================================
CREATE PROCEDURE [dbo].[GetAllVehicleManufacturers]	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT *
	FROM VehicleManufacturer
	ORDER BY VehicleManufacturerID DESC
END