-- =============================================
-- Author:		Nino Omic
-- Create date: 23.09.2022
-- Description:	Returns count of vehicles
-- =============================================
CREATE FUNCTION [dbo].[CountOfVehicles]()
RETURNS int
AS
BEGIN
	DECLARE @CountOfVehicles INT = 0
	SET @CountOfVehicles = (SELECT COUNT(VehicleID) FROM Vehicle)
	RETURN @CountOfVehicles

END