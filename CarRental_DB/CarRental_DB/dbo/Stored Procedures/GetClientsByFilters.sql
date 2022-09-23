-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Returns filtered clients
-- S ovim nacinom filtriranja, ako zelimo dodati novi parametar to znaci da moramo dodati i u stored proceduri i u c# kodu,
-- ali zadatak je zahtjevao da se komunikacija sa bazom obavlja preko stored procedura pa sam ovako uradio
-- =============================================
CREATE PROCEDURE [dbo].[GetClientsByFilters]
	@Firstname nvarchar(200), @Lastname nvarchar(200), @DriverLicenceNumber nvarchar(20), @PersonalIDCardNumber nvarchar(20), @Birthdate date, @Gender char
	,@PageNumber INT = 1, @RowsPerPage INT = 10
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Client
	WHERE (Firstname = @Firstname OR @Firstname IS NULL)
		AND (Lastname = @Lastname OR @Lastname IS NULL)
		AND (DriverLicenceNumber = @DriverLicenceNumber OR @DriverLicenceNumber IS NULL)
		AND (PersonalIDCardNumber = @PersonalIDCardNumber OR @PersonalIDCardNumber IS NULL)
		AND (Birthdate = @Birthdate OR @Birthdate IS NULL)
		AND (Gender = @Gender OR @Gender IS NULL)
	ORDER BY ClientID
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
END