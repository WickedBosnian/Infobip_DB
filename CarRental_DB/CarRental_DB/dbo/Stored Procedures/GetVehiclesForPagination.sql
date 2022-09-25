-- =============================================
-- Author:		Nino Omic
-- Create date: 23.09.2022
-- Description:	Returns vehicles for pagination based on number of records per page
-- =============================================
CREATE PROCEDURE [dbo].[GetVehiclesForPagination] 
	@PageNumber INT = 1, @RowsPerPage INT = 10
AS
	SELECT *
	FROM Vehicle
	ORDER BY VehicleID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;