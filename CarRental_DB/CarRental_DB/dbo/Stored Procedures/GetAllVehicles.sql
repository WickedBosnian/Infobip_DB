-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns all records from Vehicle table
-- =============================================
CREATE PROCEDURE [dbo].[GetAllVehicles] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Vehicle
	ORDER BY VehicleID DESC
END