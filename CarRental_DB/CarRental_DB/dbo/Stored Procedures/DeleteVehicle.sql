-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Deletes a record from Vehicle table based on ID
-- =============================================
CREATE PROCEDURE [dbo].[DeleteVehicle]
	@VehicleId int
AS
SET NOCOUNT ON

BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM Vehicle WHERE VehicleID = @VehicleId) < 1
			RAISERROR('Vehicle with this ID does not exist!', 11, 1);

		DELETE FROM Vehicle
		WHERE VehicleId = @VehicleId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
        ROLLBACK TRAN;

	THROW;
END CATCH