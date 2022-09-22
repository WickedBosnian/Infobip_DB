-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns all records from Client table
-- =============================================
CREATE PROCEDURE [dbo].[GetAllClients]
	@PageNumber INT = 1, @RowsPerPage INT = 10
AS
SELECT *
FROM Client
ORDER BY ClientID
OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
FETCH NEXT @RowsPerPage ROWS ONLY;