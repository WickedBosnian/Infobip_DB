-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Deletes vehicle type based on ID
-- =============================================
CREATE PROCEDURE [dbo].[DeleteVehicleType] 
	@VehicleTypeId int
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		BEGIN TRAN
			IF(SELECT COUNT(*) FROM VehicleType WHERE VehicleTypeID = @VehicleTypeId) < 1
				RAISERROR('Vehicle type with this ID does not exist!', 11, 1);

			DELETE FROM VehicleType
			WHERE VehicleTypeID = @VehicleTypeId
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH
END