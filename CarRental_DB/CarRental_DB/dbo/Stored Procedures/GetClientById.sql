-- =============================================
-- Author:		Nino Omic
-- Create date: 17.09.2022
-- Description:	Returns a record from table Client based on ID
-- =============================================
CREATE PROCEDURE [dbo].[GetClientById] @ClientId int
AS
BEGIN
	SELECT TOP 1 *
	FROM Client
	WHERE ClientID = @ClientId
END