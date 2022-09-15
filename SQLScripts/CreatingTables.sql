CREATE DATABASE CarRental
USE CarRental

CREATE TABLE Client
(
	ClientID INT IDENTITY(1,1) PRIMARY KEY
	, Firstname NVARCHAR(200) NOT NULL
	, Lastname NVARCHAR(200) NOT NULL
	, Birthdate DATETIME
	, Gender CHAR(1)
	, DriverLicenceNumber NVARCHAR(20) NOT NULL
	, PersonalIDCardNumber NVARCHAR(20)
	, CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
	, ModifiedDate DATETIME
	--S obzirom da ova tabela nece sadrziti velike kolicine podataka ovi indexi nece imati uticaja na performanse
	--Medjutim, s obzirom na to da ce se raditi filtriranja i pretrage po ovim poljima, odlucio sam da napravim indexe jer u stvarnom projektu bih tako uradio na poljima na kojima se rade ceste pretrage
	, INDEX IX_Firstname NONCLUSTERED (Firstname)
	, INDEX IX_Lastname NONCLUSTERED (Lastname)
)

CREATE TABLE VehicleType
(
	VehicleTypeID INT IDENTITY(1,1) PRIMARY KEY
	, VehicleTypeName NVARCHAR(200) NOT NULL
	, VehicleTypeDescription NVARCHAR
	, CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
	, ModifiedDate DATETIME
)

CREATE TABLE VehicleManufacturer
(
	VehicleManufacturerID INT IDENTITY(1,1) PRIMARY KEY
	, VehicleManufacturerName NVARCHAR(200) NOT NULL
	, VehicleManufacturerDescription NVARCHAR
	, CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
	, ModifiedDate DATETIME
)

CREATE TABLE Vehicle
(
	VehicleID INT IDENTITY(1,1) PRIMARY KEY
	, VehicleManufacturerID INT NOT NULL
	, VehicleTypeID INT NOT NULL
	, Color NVARCHAR(20)
	, DateManufactured DATE NOT NULL 
	, PricePerDay DECIMAL(19,4) NOT NULL
	, CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
	, ModifiedDate DATETIME
	, FOREIGN KEY (VehicleTypeID) REFERENCES VehicleType(VehicleTypeID)
	, FOREIGN KEY (VehicleManufacturerID) REFERENCES VehicleManufacturer(VehicleManufacturerID)
)

CREATE TABLE Reservation
(
	ReservationID INT IDENTITY(1,1) PRIMARY KEY
	, ClientID INT NOT NULL
	, ReservationDateFrom DATETIME NOT NULL
	, ReservationDateTo DATETIME NOT NULL
	, Active BIT NOT NULL
	, CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
	, ModifiedDate DATETIME
	, FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
)

CREATE TABLE ReservedVehicle
(
	ReservedVehicleID INT IDENTITY(1,1) PRIMARY KEY
	, ReservationID INT NOT NULL
	, VehicleID INT NOT NULL
	, CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
	, FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
	, FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
)

GO