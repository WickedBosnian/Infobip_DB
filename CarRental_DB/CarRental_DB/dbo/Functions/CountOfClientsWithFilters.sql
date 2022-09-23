-- =============================================
-- Author:		Nino Omic
-- Create date: 22.09.2022
-- Description:	Returns countof filtered clients
-- =============================================
CREATE FUNCTION [dbo].[CountOfClientsWithFilters] 
(
	@Firstname nvarchar(200), @Lastname nvarchar(200), @DriverLicenceNumber nvarchar(20), @PersonalIDCardNumber nvarchar(20), @Birthdate date, @Gender char
)
RETURNS int
AS
BEGIN
	DECLARE @CountOfClients INT = 0

	SET @CountOfClients = (SELECT COUNT(ClientID)
			FROM Client
			WHERE (Firstname = @Firstname OR @Firstname IS NULL)
				AND (Lastname = @Lastname OR @Lastname IS NULL)
				AND (DriverLicenceNumber = @DriverLicenceNumber OR @DriverLicenceNumber IS NULL)
				AND (PersonalIDCardNumber = @PersonalIDCardNumber OR @PersonalIDCardNumber IS NULL)
				AND (Birthdate = @Birthdate OR @Birthdate IS NULL)
				AND (Gender = @Gender OR @Gender IS NULL)
		)

	RETURN @CountofClients

END