-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Creates a reservation
-- =============================================
CREATE PROCEDURE [dbo].[CreateReservation]
 @ClientId int, @VehicleId int, @ReservationDateFrom datetime, @ReservationDateTo datetime
AS
	SET NOCOUNT ON;
BEGIN TRY
	BEGIN TRAN

		IF dbo.GetNumberOfActiveReservationsForClient(@ClientID) >= 3
			RAISERROR('This client has 3 active reservations. This is the maximum number of active reservations a client can have at once!', 11, 1);

		IF dbo.IsVehicleReservedForPeriod(@VehicleId, @ReservationDateFrom, @ReservationDateTo) = 1
			RAISERROR('This vehicle is already reserved for this period!', 11, 1);

		IF dbo.GetNumberOfReservationsWithSameVehicleTypeForClient(@ClientId, @VehicleId, @ReservationDateFrom, @ReservationDateTo) >= 1
			RAISERROR('Two vehicles of the same type can not be reserved at the same time by the same client!', 11, 1);

		INSERT INTO [dbo].[Reservation]
			   ([ClientID]
			   ,[VehicleID]
			   ,[ReservationDateFrom]
			   ,[ReservationDateTo]
			   ,[Active])
		 VALUES
			   (@ClientId
			   ,@VehicleId
			   ,@ReservationDateFrom
			   ,@ReservationDateTo
			   ,1)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
        ROLLBACK TRAN;

	THROW;
END CATCH

SELECT CONVERT(int, SCOPE_IDENTITY())