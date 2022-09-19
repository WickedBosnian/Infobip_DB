-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns vehicle type by ID
-- =============================================
CREATE PROCEDURE GetVehicleTypeById
	@VehicleTypeId int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT *
	FROM VehicleType
	WHERE VehicleTypeID = @VehicleTypeId
END