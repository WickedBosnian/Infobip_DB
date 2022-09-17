CREATE PROCEDURE [dbo].[UpdateClient]
@ClientId int
, @Firstname nvarchar(200)
, @Lastname nvarchar(200)
, @DriverLicenceNumber nvarchar(20)
, @PersonalIDCardNumber nvarchar(20)
, @Birthdate datetime
, @Gender char
AS
UPDATE Client SET Firstname = ISNULL(@Firstname, Firstname)
	, Lastname = ISNULL(@Lastname, Lastname)
	, Birthdate = ISNULL(@Birthdate, Birthdate)
	, Gender = ISNULL(@Gender, Gender)
	, DriverLicenceNumber = ISNULL(@DriverLicenceNumber, DriverLicenceNumber)
	, PersonalIDCardNumber = ISNULL(@PersonalIDCardNumber, PersonalIDCardNumber)
	, ModifiedDate = GETDATE()
WHERE ClientID = @ClientId