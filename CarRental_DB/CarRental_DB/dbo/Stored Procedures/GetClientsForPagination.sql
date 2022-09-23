-- =============================================
-- Author:		Nino Omic
-- Create date: 23.09.2022
-- Description:	Returns clients for pagination based on page number and number of records per page
-- =============================================
CREATE PROCEDURE GetClientsForPagination
	@PageNumber INT = 1, @RowsPerPage INT = 10
AS
	SELECT *
	FROM Client
	ORDER BY ClientID
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;