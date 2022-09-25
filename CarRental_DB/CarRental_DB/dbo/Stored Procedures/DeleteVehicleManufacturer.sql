-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Deletes record from VehicleManufacturer table based on ID
-- =============================================
CREATE PROCEDURE [dbo].[DeleteVehicleManufacturer]
	@VehicleManufacturerId int
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		BEGIN TRAN
			IF(SELECT COUNT(*) FROM VehicleManufacturer WHERE VehicleManufacturerID = @VehicleManufacturerId) < 1
				RAISERROR('Vehicle Manufacturer with this ID does not exist!', 11, 1);

			DELETE FROM VehicleManufacturer
			WHERE VehicleManufacturerID = @VehicleManufacturerId
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH
END