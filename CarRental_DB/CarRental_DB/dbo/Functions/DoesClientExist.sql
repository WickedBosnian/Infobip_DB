-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns true or false depending if the client exists
-- =============================================
CREATE FUNCTION DoesClientExist
(
	@ClientID int
)
RETURNS bit
AS
BEGIN
	DECLARE @ClientExists bit = 0

	IF(SELECT COUNT(*) FROM Client WHERE ClientID = @ClientID) >= 1
		SET @ClientExists = 1

	RETURN @ClientExists

END