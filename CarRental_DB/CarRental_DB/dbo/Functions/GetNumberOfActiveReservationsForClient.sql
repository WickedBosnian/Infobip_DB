-- =============================================
-- Author:		Nino Omic
-- Create date: 2022-09-19
-- Description:	Returns number of active reservations for a client
-- =============================================
CREATE FUNCTION [dbo].[GetNumberOfActiveReservationsForClient]
(
	@Client int
)
RETURNS int
AS
BEGIN
	DECLARE @NumberOfReservations int

	SET @NumberOfReservations = (SELECT COUNT(*) FROM Reservation AS R WHERE R.ClientID = @Client AND R.Active = 1)

	RETURN @NumberOfReservations

END