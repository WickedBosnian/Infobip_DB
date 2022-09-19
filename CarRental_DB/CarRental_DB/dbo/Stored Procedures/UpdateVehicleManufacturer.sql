-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Updates VehicleManufacturer record
-- =============================================
CREATE PROCEDURE [dbo].[UpdateVehicleManufacturer]
	@VehicleManufacturerId int, @VehicleManufacturerName nvarchar(200), @VehicleManufacturerDescription nvarchar(max)
AS
BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM VehicleManufacturer WHERE VehicleManufacturerID = @VehicleManufacturerId) < 1
			RAISERROR('Vehicle Manufacturer with this ID does not exist!', 11, 1);

		UPDATE VehicleManufacturer SET VehicleManufacturerName = ISNULL(@VehicleManufacturerName, VehicleManufacturerName)
			, VehicleManufacturerDescription = ISNULL(@VehicleManufacturerDescription, VehicleManufacturerDescription)
			, ModifiedDate = GETDATE()
		WHERE VehicleManufacturerID = @VehicleManufacturerId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
		ROLLBACK TRAN;
	THROW;
END CATCH