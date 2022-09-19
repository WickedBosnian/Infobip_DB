-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Inserts new record in VehicleManfacturer table
-- =============================================
CREATE PROCEDURE CreateVehicleManufacturer
	@VehicleManufacturerName nvarchar(200), @VehicleManufacturerDescription nvarchar(max)
AS
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO VehicleManufacturer
				(VehicleManufacturerName, VehicleManufacturerDescription)
			VALUES
				(@VehicleManufacturerName, @VehicleManufacturerDescription)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH

	SELECT CONVERT(int, SCOPE_IDENTITY())