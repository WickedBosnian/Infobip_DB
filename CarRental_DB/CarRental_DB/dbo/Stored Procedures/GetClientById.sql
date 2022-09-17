CREATE PROCEDURE [dbo].[GetClientById] @ClientId int
AS
SELECT *
FROM Client
WHERE ClientID = @ClientId