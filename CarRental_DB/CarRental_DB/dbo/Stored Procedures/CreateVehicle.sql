-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Inserts a record in Vehicle table
-- =============================================
CREATE PROCEDURE [dbo].[CreateVehicle]
@VehicleName nvarchar(200)
	, @VehicleManufacturerId int
	, @VehicleTypeId int
	, @Color nvarchar(20)
	, @DateManufactured date
	, @PricePerDay decimal(19,4)
AS
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRAN
			IF dbo.DoesManufacturerExist(@VehicleManufacturerId) = 0
				RAISERROR('Vehicle Manufacturer with this ID does not exist!', 11, 1);

			IF dbo.DoesVehicleTypeExist(@VehicleTypeId) = 0
				RAISERROR('Vehicle type with this ID does not exist!', 11, 1);

			INSERT INTO Vehicle
				(VehicleName, VehicleManufacturerID, VehicleTypeID, Color, DateManufactured, PricePerDay)
			VALUES
				(@VehicleName, @VehicleManufacturerID, @VehicleTypeID, @Color, @DateManufactured, @PricePerDay)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH

SELECT CONVERT(int, SCOPE_IDENTITY())