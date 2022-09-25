-- =============================================
-- Author:		Nino Omic
-- Create date: 17.09.2022
-- Description:	Inserts a record in Client table
-- =============================================
CREATE PROCEDURE [dbo].[CreateClient]
@Firstname nvarchar(200), @Lastname nvarchar(200), @DriverLicenceNumber nvarchar(20), @PersonalIDCardNumber nvarchar(20), @Birthdate datetime, @Gender char
AS
SET NOCOUNT ON
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Client
			(Firstname, Lastname, Birthdate, Gender, DriverLicenceNumber, PersonalIDCardNumber)
		VALUES
			(@Firstname, @Lastname, @Birthdate, @Gender, @DriverLicenceNumber, @PersonalIDCardNumber)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
        ROLLBACK TRAN;

	THROW
END CATCH

SELECT CONVERT(int, SCOPE_IDENTITY())