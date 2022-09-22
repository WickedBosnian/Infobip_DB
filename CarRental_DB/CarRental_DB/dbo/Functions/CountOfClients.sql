-- =============================================
-- Author:		Nino Omic
-- Create date: 21.09.2022
-- Description:	Returns count of clients
-- =============================================
CREATE FUNCTION CountOfClients()
RETURNS int
AS
BEGIN
	DECLARE @CountOfClients INT
	SET @CountOfClients = (SELECT COUNT(ClientID) FROM Client)
	RETURN @CountOfClients
END