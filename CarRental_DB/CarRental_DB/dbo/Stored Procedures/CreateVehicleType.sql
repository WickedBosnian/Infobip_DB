-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Inserts a record in Vehicle Types table
-- =============================================
CREATE PROCEDURE [dbo].[CreateVehicleType]
	@VehicleTypeName nvarchar(200), @VehicleTypeDescription nvarchar(max)
AS
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO VehicleType
				(VehicleTypeName, VehicleTypeDescription)
			VALUES
				(@VehicleTypeName, @VehicleTypeDescription)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH

	SELECT CONVERT(int, SCOPE_IDENTITY())