-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Cancels a reservation, sets field Active to 0/false
-- =============================================
CREATE PROCEDURE [dbo].[CancelReservation]
	@ReservationId int
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRAN
			UPDATE Reservation
			SET Active = 0, ModifiedDate = GETDATE(), CanceledDate = GETDATE()
			WHERE ReservationID = @ReservationId
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH
END