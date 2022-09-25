-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns a record from Vehicle table based on Id
-- =============================================
CREATE PROCEDURE [dbo].[GetVehicleById]
	@VehicleId int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT TOP 1 *
	FROM Vehicle
	WHERE VehicleID = @VehicleId
END