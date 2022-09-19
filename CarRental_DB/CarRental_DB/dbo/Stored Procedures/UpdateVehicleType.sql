-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Updates Vehicle Type
-- =============================================
CREATE PROCEDURE [dbo].[UpdateVehicleType]
	@VehicleTypeId int, @VehicleTypeName nvarchar(200), @VehicleTypeDescription nvarchar(max)
AS
BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM VehicleType WHERE VehicleTypeID = @VehicleTypeId) < 1
			RAISERROR('Vehicle type with this ID does not exist!', 11, 1);

		UPDATE VehicleType SET VehicleTypeName = ISNULL(@VehicleTypeName, VehicleTypeName)
			, VehicleTypeDescription = ISNULL(@VehicleTypeDescription, VehicleTypeDescription)
			, ModifiedDate = GETDATE()
		WHERE VehicleTypeID = @VehicleTypeId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
		ROLLBACK TRAN;

	THROW;
END CATCH