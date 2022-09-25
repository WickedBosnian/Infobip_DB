-- =============================================
-- Author:		Nino Omic
-- Create date: 17.09.2022
-- Description:	Returns all records from Client table
-- =============================================
CREATE PROCEDURE [dbo].[GetAllClients]
AS
SELECT *
FROM Client
ORDER BY ClientID DESC