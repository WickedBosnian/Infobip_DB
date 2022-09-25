-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns all vehicle types
-- =============================================
CREATE PROCEDURE [dbo].[GetAllVehicleTypes]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM VehicleType
	ORDER BY VehicleTypeID DESC
END