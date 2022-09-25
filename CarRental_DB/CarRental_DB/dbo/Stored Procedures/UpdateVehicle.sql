-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Updates a record in Vehicle table
-- =============================================
CREATE PROCEDURE [dbo].[UpdateVehicle]
	@VehicleId int
	, @VehicleName nvarchar(200)
	, @VehicleManufacturerId int
	, @VehicleTypeId int
	, @Color nvarchar(20)
	, @DateManufactured date
	, @PricePerDay decimal(19,4)
AS

BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM Vehicle WHERE VehicleID = @VehicleId) < 1
			RAISERROR('Vehicle with this ID does not exist!', 11, 1);

		UPDATE Vehicle SET VehicleName = ISNULL(@VehicleName, VehicleName)
			, VehicleManufacturerID = ISNULL(@VehicleManufacturerID, VehicleManufacturerID)
			, VehicleTypeId = ISNULL(@VehicleTypeId, VehicleTypeId)
			, Color = ISNULL(@Color, Color)
			, DateManufactured = ISNULL(@DateManufactured, DateManufactured)
			, PricePerDay = ISNULL(@PricePerDay, PricePerDay)
			, ModifiedDate = GETDATE()
		WHERE VehicleID = @VehicleId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
		ROLLBACK TRAN;
	THROW;
END CATCH