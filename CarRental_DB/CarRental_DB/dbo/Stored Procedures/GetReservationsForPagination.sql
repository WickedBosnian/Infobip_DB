-- =============================================
-- Author:		Nino Omic
-- Create date: 24.09.2022
-- Description:	Returns records from Reservation table for pagination based on page number and rows per page
-- =============================================
CREATE PROCEDURE [dbo].[GetReservationsForPagination]
	@PageNumber INT = 1, @RowsPerPage INT = 10
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM Reservation
	ORDER BY ReservationID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
END