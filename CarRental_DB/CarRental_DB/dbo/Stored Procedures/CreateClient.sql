CREATE PROCEDURE [dbo].[CreateClient]
@Firstname nvarchar(200), @Lastname nvarchar(200), @DriverLicenceNumber nvarchar(20), @PersonalIDCardNumber nvarchar(20), @Birthdate datetime, @Gender char
AS
INSERT INTO Client
(Firstname, Lastname, Birthdate, Gender, DriverLicenceNumber, PersonalIDCardNumber)
VALUES
(
@Firstname, @Lastname, @Birthdate, @Gender, @DriverLicenceNumber, @PersonalIDCardNumber
)

SELECT *
FROM Client
WHERE ClientID = (SELECT SCOPE_IDENTITY())