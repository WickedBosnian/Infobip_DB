USE [master]
GO
/****** Object:  Database [CarRental]    Script Date: 25. 9. 2022. 14:56:02 ******/
CREATE DATABASE [CarRental]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CarRental', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CarRental.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CarRental_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CarRental_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CarRental] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CarRental].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CarRental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CarRental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CarRental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CarRental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CarRental] SET ARITHABORT OFF 
GO
ALTER DATABASE [CarRental] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CarRental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CarRental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CarRental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CarRental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CarRental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CarRental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CarRental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CarRental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CarRental] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CarRental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CarRental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CarRental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CarRental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CarRental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CarRental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CarRental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CarRental] SET RECOVERY FULL 
GO
ALTER DATABASE [CarRental] SET  MULTI_USER 
GO
ALTER DATABASE [CarRental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CarRental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CarRental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CarRental] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CarRental] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CarRental] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CarRental] SET QUERY_STORE = OFF
GO
USE [CarRental]
GO
/****** Object:  UserDefinedFunction [dbo].[CountOfClients]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 21.09.2022
-- Description:	Returns count of clients
-- =============================================
CREATE FUNCTION [dbo].[CountOfClients]()
RETURNS int
AS
BEGIN
	DECLARE @CountOfClients INT
	SET @CountOfClients = (SELECT COUNT(ClientID) FROM Client)
	RETURN @CountOfClients
END
GO
/****** Object:  UserDefinedFunction [dbo].[CountOfClientsWithFilters]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  UserDefinedFunction [dbo].[CountOfReservations]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 24.09.2022
-- Description:	Returns number of records from Reservation table
-- =============================================
CREATE FUNCTION [dbo].[CountOfReservations]()
RETURNS int
AS
BEGIN
	DECLARE @CountOfReservations INT
	SET @CountOfReservations = (SELECT COUNT(ReservationID) FROM Reservation)
	RETURN @CountOfReservations
END
GO
/****** Object:  UserDefinedFunction [dbo].[CountOfReservationsWithFilters]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 24.09.2022
-- Description:	Returns number of records from table Reservation based on input parameters
-- =============================================
CREATE FUNCTION [dbo].[CountOfReservationsWithFilters] 
(
	@DateFrom datetime, @DateTo datetime, @ClientId int, @VehicleId int, @Active bit
)
RETURNS INT
AS
BEGIN
	DECLARE @CountOfReservations INT = 0

	SET @CountOfReservations = (SELECT COUNT(ReservationID)
		FROM Reservation
		WHERE (ReservationDateFrom >= @DateFrom OR @DateFrom IS NULL)
			AND (ReservationDateTo <= @DateTo OR @DateTo IS NULL)
			AND (ClientID = @ClientId OR @ClientId IS NULL)
			AND (VehicleID = @VehicleId OR @VehicleId IS NULL)
			AND (Active = @Active OR @Active IS NULL))

	RETURN @CountOfReservations
END
GO
/****** Object:  UserDefinedFunction [dbo].[CountOfVehicles]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 23.09.2022
-- Description:	Returns count of vehicles
-- =============================================
CREATE FUNCTION [dbo].[CountOfVehicles]()
RETURNS int
AS
BEGIN
	DECLARE @CountOfVehicles INT = 0
	SET @CountOfVehicles = (SELECT COUNT(VehicleID) FROM Vehicle)
	RETURN @CountOfVehicles

END
GO
/****** Object:  UserDefinedFunction [dbo].[CountOfVehiclesWithFilters]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 23.09.2022
-- Description:	Returns count of filtered vehicles
-- =============================================
CREATE FUNCTION [dbo].[CountOfVehiclesWithFilters]
(
	@VehicleName nvarchar(200), @VehicleManufacturerId nvarchar(200), @VehicleTypeId int
)
RETURNS int
AS
BEGIN
	DECLARE @CountOfVehicles INT = 0

	SET @CountOfVehicles = (SELECT COUNT(VehicleID)
			FROM Vehicle
			WHERE (VehicleName = @VehicleName OR @VehicleName IS NULL)
				AND (VehicleManufacturerID = @VehicleManufacturerId OR @VehicleManufacturerId IS NULL)
				AND (VehicleTypeID = @VehicleTypeId OR @VehicleTypeId IS NULL)
		)

	RETURN @CountOfVehicles

END
GO
/****** Object:  UserDefinedFunction [dbo].[DoesClientExist]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns true or false depending if the client exists
-- =============================================
CREATE FUNCTION [dbo].[DoesClientExist]
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
GO
/****** Object:  UserDefinedFunction [dbo].[DoesManufacturerExist]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns true or false depending if the vehicle manufacturer exists
-- =============================================
CREATE FUNCTION [dbo].[DoesManufacturerExist]
(
	@ManufacturerId int
)
RETURNS bit
AS
BEGIN
	DECLARE @MnufacturerExists bit = 0

	IF(SELECT COUNT(*) FROM VehicleManufacturer WHERE VehicleManufacturerID = @ManufacturerId) >= 1
		SET @MnufacturerExists = 1

	RETURN @MnufacturerExists

END
GO
/****** Object:  UserDefinedFunction [dbo].[DoesVehicleExist]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns true or false depending if the vehicle exists
-- =============================================
CREATE FUNCTION [dbo].[DoesVehicleExist]
(
	@VehicleId int
)
RETURNS bit
AS
BEGIN
	DECLARE @VehicleExists bit = 0

	IF(SELECT COUNT(*) FROM Vehicle WHERE VehicleID = @VehicleId) >= 1
		SET @VehicleExists = 1

	RETURN @VehicleExists

END
GO
/****** Object:  UserDefinedFunction [dbo].[DoesVehicleTypeExist]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns true or false depending if the vehicle type exists
-- =============================================
CREATE FUNCTION [dbo].[DoesVehicleTypeExist]
(
	@TypeId int
)
RETURNS bit
AS
BEGIN
	DECLARE @VehicleTypeExists bit = 0

	IF(SELECT COUNT(*) FROM VehicleType WHERE VehicleTypeID = @TypeId) >= 1
		SET @VehicleTypeExists = 1

	RETURN @VehicleTypeExists

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetNumberOfActiveReservationsForClient]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 2022-09-19
-- Description:	Returns number of active reservations for a client
-- =============================================
CREATE FUNCTION [dbo].[GetNumberOfActiveReservationsForClient]
(
	@Client int
)
RETURNS int
AS
BEGIN
	DECLARE @NumberOfReservations int

	SET @NumberOfReservations = (SELECT COUNT(*) FROM Reservation AS R WHERE R.ClientID = @Client AND R.Active = 1)

	RETURN @NumberOfReservations

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetNumberOfReservationsWithSameVehicleTypeForClient]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 2022-09-19
-- Description:	Returns amount of active transactions for a client that have a vehicle of the same type
-- =============================================
CREATE FUNCTION [dbo].[GetNumberOfReservationsWithSameVehicleTypeForClient]
(
	@ClientId int, @VehicleId int
)
RETURNS int
AS
BEGIN
	DECLARE @NumberOfReservations int

	SET @NumberOfReservations = (SELECT COUNT(*)
				FROM Vehicle AS VV
				WHERE VV.VehicleID = @VehicleId
					AND VV.VehicleTypeID IN
					(
						SELECT V.VehicleTypeID
							FROM Reservation AS R
							JOIN Vehicle AS V ON V.VehicleID = R.VehicleID
							WHERE R.ClientID = @ClientId
							AND R.Active = 1
					))

	RETURN @NumberOfReservations

END
GO
/****** Object:  UserDefinedFunction [dbo].[IsVehicleReservedForPeriod]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 2022-09-19
-- Description:	Returns true if vehicle is reserved for requested period, otherwise returns false
-- =============================================
CREATE FUNCTION [dbo].[IsVehicleReservedForPeriod]
(
	@VehicleId int, @From datetime, @To datetime
)
RETURNS bit
AS
BEGIN
	DECLARE @IsReserved bit = 0

	IF(SELECT COUNT(*) 
		FROM Reservation AS R 
		JOIN Vehicle AS V ON V.VehicleID = R.VehicleID 
		WHERE R.Active = 1 
			AND R.VehicleID = @VehicleId
			AND ((R.ReservationDateFrom <= @To) AND (R.ReservationDateTo >= @From))
			) >= 1
		SET @IsReserved = 1

	RETURN @IsReserved

END
GO
/****** Object:  Table [dbo].[Client]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](200) NOT NULL,
	[Lastname] [nvarchar](200) NOT NULL,
	[Birthdate] [date] NULL,
	[Gender] [char](1) NULL,
	[DriverLicenceNumber] [nvarchar](20) NOT NULL,
	[PersonalIDCardNumber] [nvarchar](20) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[VehicleID] [int] NOT NULL,
	[ReservationDateFrom] [datetime] NOT NULL,
	[ReservationDateTo] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CanceledDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[VehicleID] [int] IDENTITY(1,1) NOT NULL,
	[VehicleName] [nvarchar](200) NOT NULL,
	[VehicleManufacturerID] [int] NOT NULL,
	[VehicleTypeID] [int] NOT NULL,
	[Color] [nvarchar](20) NULL,
	[DateManufactured] [date] NOT NULL,
	[PricePerDay] [decimal](19, 4) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VehicleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VehicleManufacturer]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleManufacturer](
	[VehicleManufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[VehicleManufacturerName] [nvarchar](200) NOT NULL,
	[VehicleManufacturerDescription] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VehicleManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VehicleType]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleType](
	[VehicleTypeID] [int] IDENTITY(1,1) NOT NULL,
	[VehicleTypeName] [nvarchar](200) NOT NULL,
	[VehicleTypeDescription] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VehicleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([ClientID], [Firstname], [Lastname], [Birthdate], [Gender], [DriverLicenceNumber], [PersonalIDCardNumber], [CreatedDate], [ModifiedDate]) VALUES (1, N'Nino', N'Omic', CAST(N'2000-09-18' AS Date), N'M', N'ORP321', N'1231', CAST(N'2022-09-18T21:40:57.630' AS DateTime), CAST(N'2022-09-23T02:01:12.990' AS DateTime))
INSERT [dbo].[Client] ([ClientID], [Firstname], [Lastname], [Birthdate], [Gender], [DriverLicenceNumber], [PersonalIDCardNumber], [CreatedDate], [ModifiedDate]) VALUES (3, N'Nina', N'Ninic', CAST(N'2000-09-10' AS Date), N'F', N'ORP3212', N'321123', CAST(N'2022-09-18T21:42:00.977' AS DateTime), CAST(N'2022-09-23T00:38:34.187' AS DateTime))
INSERT [dbo].[Client] ([ClientID], [Firstname], [Lastname], [Birthdate], [Gender], [DriverLicenceNumber], [PersonalIDCardNumber], [CreatedDate], [ModifiedDate]) VALUES (21, N'Test', N'Test', NULL, NULL, N'123412d', NULL, CAST(N'2022-09-22T00:53:16.513' AS DateTime), NULL)
INSERT [dbo].[Client] ([ClientID], [Firstname], [Lastname], [Birthdate], [Gender], [DriverLicenceNumber], [PersonalIDCardNumber], [CreatedDate], [ModifiedDate]) VALUES (26, N'Nino', N'Test', NULL, N'M', N'312123', NULL, CAST(N'2022-09-22T19:50:55.320' AS DateTime), NULL)
INSERT [dbo].[Client] ([ClientID], [Firstname], [Lastname], [Birthdate], [Gender], [DriverLicenceNumber], [PersonalIDCardNumber], [CreatedDate], [ModifiedDate]) VALUES (27, N'Nika', N'Nikic', CAST(N'1995-01-02' AS Date), N'F', N'ABC123', NULL, CAST(N'2022-09-23T00:17:24.187' AS DateTime), NULL)
INSERT [dbo].[Client] ([ClientID], [Firstname], [Lastname], [Birthdate], [Gender], [DriverLicenceNumber], [PersonalIDCardNumber], [CreatedDate], [ModifiedDate]) VALUES (32, N'Nino', N'Omic', CAST(N'1998-01-01' AS Date), N'F', N'123321', NULL, CAST(N'2022-09-25T02:06:21.100' AS DateTime), NULL)
INSERT [dbo].[Client] ([ClientID], [Firstname], [Lastname], [Birthdate], [Gender], [DriverLicenceNumber], [PersonalIDCardNumber], [CreatedDate], [ModifiedDate]) VALUES (35, N'Lejla', N'Lejlic', CAST(N'1993-07-14' AS Date), N'F', N'OLK345', NULL, CAST(N'2022-09-25T14:42:06.787' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (2, 1, 1, CAST(N'2022-01-01T00:00:00.000' AS DateTime), CAST(N'2022-01-05T00:00:00.000' AS DateTime), 1, CAST(N'2022-09-19T01:04:49.867' AS DateTime), NULL, NULL)
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (3, 1, 1, CAST(N'2022-01-01T00:00:00.000' AS DateTime), CAST(N'2022-01-02T00:00:00.000' AS DateTime), 0, CAST(N'2022-09-19T01:05:06.313' AS DateTime), NULL, NULL)
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (4, 1, 4, CAST(N'2022-09-18T00:00:00.000' AS DateTime), CAST(N'2022-09-23T00:00:00.000' AS DateTime), 1, CAST(N'2022-09-19T01:46:52.090' AS DateTime), NULL, NULL)
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (5, 1, 5, CAST(N'2022-09-24T00:00:00.000' AS DateTime), CAST(N'2022-09-25T00:00:00.000' AS DateTime), 0, CAST(N'2022-09-19T01:51:42.560' AS DateTime), CAST(N'2022-09-19T01:52:11.980' AS DateTime), CAST(N'2022-09-19T01:52:11.980' AS DateTime))
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (6, 1, 5, CAST(N'2022-09-26T00:00:00.000' AS DateTime), CAST(N'2022-09-29T00:00:00.000' AS DateTime), 1, CAST(N'2022-09-19T01:52:20.567' AS DateTime), NULL, NULL)
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (8, 3, 1, CAST(N'2022-09-19T20:44:06.457' AS DateTime), CAST(N'2022-09-20T20:44:06.457' AS DateTime), 0, CAST(N'2022-09-19T22:45:21.943' AS DateTime), CAST(N'2022-09-19T22:45:40.227' AS DateTime), CAST(N'2022-09-19T22:45:40.227' AS DateTime))
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (9, 3, 1, CAST(N'2022-09-19T20:59:52.323' AS DateTime), CAST(N'2022-09-30T20:59:52.323' AS DateTime), 0, CAST(N'2022-09-19T23:00:14.447' AS DateTime), CAST(N'2022-09-19T23:01:35.687' AS DateTime), CAST(N'2022-09-19T23:01:35.687' AS DateTime))
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (12, 3, 5, CAST(N'2022-09-19T21:17:21.900' AS DateTime), CAST(N'2022-09-19T21:17:21.900' AS DateTime), 0, CAST(N'2022-09-19T23:18:11.993' AS DateTime), CAST(N'2022-09-25T02:12:36.910' AS DateTime), CAST(N'2022-09-25T02:12:36.910' AS DateTime))
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (15, 32, 14, CAST(N'2022-09-25T00:00:00.000' AS DateTime), CAST(N'2022-09-28T00:00:00.000' AS DateTime), 1, CAST(N'2022-09-25T02:09:09.830' AS DateTime), NULL, NULL)
INSERT [dbo].[Reservation] ([ReservationID], [ClientID], [VehicleID], [ReservationDateFrom], [ReservationDateTo], [Active], [CreatedDate], [ModifiedDate], [CanceledDate]) VALUES (16, 32, 15, CAST(N'2022-09-25T00:00:00.000' AS DateTime), CAST(N'2022-09-28T00:00:00.000' AS DateTime), 1, CAST(N'2022-09-25T02:11:36.957' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Reservation] OFF
GO
SET IDENTITY_INSERT [dbo].[Vehicle] ON 

INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (1, N'Audi A6', 1, 2, N'Blue', CAST(N'2019-12-29' AS Date), CAST(90.5500 AS Decimal(19, 4)), CAST(N'2022-09-19T01:00:17.520' AS DateTime), CAST(N'2022-09-24T01:03:46.617' AS DateTime))
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (2, N'BMW 1', 2, 1, N'Black', CAST(N'2022-01-01' AS Date), CAST(120.0000 AS Decimal(19, 4)), CAST(N'2022-09-19T01:00:37.297' AS DateTime), NULL)
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (3, N'Audi A5', 1, 1, N'Green', CAST(N'2019-01-01' AS Date), CAST(80.0000 AS Decimal(19, 4)), CAST(N'2022-09-19T01:01:14.003' AS DateTime), NULL)
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (4, N'Mercedes Vito', 3, 4, N'Grey', CAST(N'2019-05-01' AS Date), CAST(80.0000 AS Decimal(19, 4)), CAST(N'2022-09-19T01:02:25.777' AS DateTime), NULL)
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (5, N'Neki kombi', 1, 4, N'Cyan', CAST(N'2000-01-01' AS Date), CAST(40.0000 AS Decimal(19, 4)), CAST(N'2022-09-19T01:50:18.483' AS DateTime), NULL)
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (10, N'Audi A6', 1, 2, N'Red', CAST(N'2022-09-01' AS Date), CAST(19912.0000 AS Decimal(19, 4)), CAST(N'2022-09-23T23:27:39.943' AS DateTime), NULL)
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (11, N'Mercedes AMG', 1, 2, NULL, CAST(N'2022-09-01' AS Date), CAST(22.0000 AS Decimal(19, 4)), CAST(N'2022-09-24T00:19:32.187' AS DateTime), NULL)
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (12, N'Mercedes AMG 2', 1, 1, NULL, CAST(N'2022-09-08' AS Date), CAST(22.1100 AS Decimal(19, 4)), CAST(N'2022-09-24T00:50:55.167' AS DateTime), NULL)
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (13, N'Mercedes AMG 2', 3, 2, N'Black', CAST(N'2022-09-01' AS Date), CAST(200.0000 AS Decimal(19, 4)), CAST(N'2022-09-24T00:59:01.843' AS DateTime), NULL)
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (14, N'Audi A8', 1, 2, N'Grey', CAST(N'2022-08-28' AS Date), CAST(155.5500 AS Decimal(19, 4)), CAST(N'2022-09-24T01:07:40.387' AS DateTime), CAST(N'2022-09-24T01:08:03.430' AS DateTime))
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (15, N'Volvo V60', 8, 5, N'Red', CAST(N'2022-09-03' AS Date), CAST(200.0000 AS Decimal(19, 4)), CAST(N'2022-09-24T11:47:53.470' AS DateTime), CAST(N'2022-09-24T11:48:16.623' AS DateTime))
INSERT [dbo].[Vehicle] ([VehicleID], [VehicleName], [VehicleManufacturerID], [VehicleTypeID], [Color], [DateManufactured], [PricePerDay], [CreatedDate], [ModifiedDate]) VALUES (16, N'Toyota Supra', 7, 10, N'Green', CAST(N'2022-09-01' AS Date), CAST(188.9800 AS Decimal(19, 4)), CAST(N'2022-09-24T12:09:12.273' AS DateTime), CAST(N'2022-09-25T12:48:48.840' AS DateTime))
SET IDENTITY_INSERT [dbo].[Vehicle] OFF
GO
SET IDENTITY_INSERT [dbo].[VehicleManufacturer] ON 

INSERT [dbo].[VehicleManufacturer] ([VehicleManufacturerID], [VehicleManufacturerName], [VehicleManufacturerDescription], [CreatedDate], [ModifiedDate]) VALUES (1, N'Audi', N'Kompanija audi', CAST(N'2022-09-19T00:54:26.013' AS DateTime), NULL)
INSERT [dbo].[VehicleManufacturer] ([VehicleManufacturerID], [VehicleManufacturerName], [VehicleManufacturerDescription], [CreatedDate], [ModifiedDate]) VALUES (2, N'BMW', NULL, CAST(N'2022-09-19T00:54:31.133' AS DateTime), NULL)
INSERT [dbo].[VehicleManufacturer] ([VehicleManufacturerID], [VehicleManufacturerName], [VehicleManufacturerDescription], [CreatedDate], [ModifiedDate]) VALUES (3, N'Mercedes', N'Mercedes kompanija', CAST(N'2022-09-19T00:54:43.533' AS DateTime), NULL)
INSERT [dbo].[VehicleManufacturer] ([VehicleManufacturerID], [VehicleManufacturerName], [VehicleManufacturerDescription], [CreatedDate], [ModifiedDate]) VALUES (7, N'Toyota', N'Japanska firma', CAST(N'2022-09-23T01:25:24.527' AS DateTime), NULL)
INSERT [dbo].[VehicleManufacturer] ([VehicleManufacturerID], [VehicleManufacturerName], [VehicleManufacturerDescription], [CreatedDate], [ModifiedDate]) VALUES (8, N'Volvo', N'Svedska firma', CAST(N'2022-09-23T02:01:45.850' AS DateTime), CAST(N'2022-09-23T02:01:54.850' AS DateTime))
SET IDENTITY_INSERT [dbo].[VehicleManufacturer] OFF
GO
SET IDENTITY_INSERT [dbo].[VehicleType] ON 

INSERT [dbo].[VehicleType] ([VehicleTypeID], [VehicleTypeName], [VehicleTypeDescription], [CreatedDate], [ModifiedDate]) VALUES (1, N'Karavan', N'Duze auto', CAST(N'2022-09-19T00:52:38.643' AS DateTime), NULL)
INSERT [dbo].[VehicleType] ([VehicleTypeID], [VehicleTypeName], [VehicleTypeDescription], [CreatedDate], [ModifiedDate]) VALUES (2, N'Limuzina', N'Normalno auto, nije ona limuzina', CAST(N'2022-09-19T00:52:59.140' AS DateTime), CAST(N'2022-09-23T01:26:15.140' AS DateTime))
INSERT [dbo].[VehicleType] ([VehicleTypeID], [VehicleTypeName], [VehicleTypeDescription], [CreatedDate], [ModifiedDate]) VALUES (3, N'Hatchback', N'Krace auto', CAST(N'2022-09-19T00:53:08.310' AS DateTime), NULL)
INSERT [dbo].[VehicleType] ([VehicleTypeID], [VehicleTypeName], [VehicleTypeDescription], [CreatedDate], [ModifiedDate]) VALUES (4, N'Kombi', N'Vozilo sa vise od 5 sjedista', CAST(N'2022-09-19T00:53:31.663' AS DateTime), NULL)
INSERT [dbo].[VehicleType] ([VehicleTypeID], [VehicleTypeName], [VehicleTypeDescription], [CreatedDate], [ModifiedDate]) VALUES (5, N'Kabriolet', N'Auto bez krova', CAST(N'2022-09-19T14:07:45.500' AS DateTime), NULL)
INSERT [dbo].[VehicleType] ([VehicleTypeID], [VehicleTypeName], [VehicleTypeDescription], [CreatedDate], [ModifiedDate]) VALUES (10, N'Sport', N'Auto za utrkivanje', CAST(N'2022-09-24T12:08:25.007' AS DateTime), CAST(N'2022-09-24T12:08:40.900' AS DateTime))
SET IDENTITY_INSERT [dbo].[VehicleType] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Client__9EB642A815B01DDE]    Script Date: 25. 9. 2022. 14:56:02 ******/
ALTER TABLE [dbo].[Client] ADD UNIQUE NONCLUSTERED 
(
	[DriverLicenceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Firstname]    Script Date: 25. 9. 2022. 14:56:02 ******/
CREATE NONCLUSTERED INDEX [IX_Firstname] ON [dbo].[Client]
(
	[Firstname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Lastname]    Script Date: 25. 9. 2022. 14:56:02 ******/
CREATE NONCLUSTERED INDEX [IX_Lastname] ON [dbo].[Client]
(
	[Lastname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Client] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Reservation] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Vehicle] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[VehicleManufacturer] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[VehicleType] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ClientID])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([VehicleID])
REFERENCES [dbo].[Vehicle] ([VehicleID])
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD FOREIGN KEY([VehicleTypeID])
REFERENCES [dbo].[VehicleType] ([VehicleTypeID])
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD FOREIGN KEY([VehicleManufacturerID])
REFERENCES [dbo].[VehicleManufacturer] ([VehicleManufacturerID])
GO
/****** Object:  StoredProcedure [dbo].[CancelReservation]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Cancels a reservation, sets field Active to 0/false
-- =============================================
CREATE PROCEDURE [dbo].[CancelReservation]
	@ReservationId int
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRAN
			IF(SELECT COUNT(*) FROM Reservation WHERE ReservationID = @ReservationId) < 1
				RAISERROR('Reservation with this ID does not exist!', 11, 1);

			UPDATE Reservation
			SET Active = 0, ModifiedDate = GETDATE(), CanceledDate = GETDATE()
			WHERE ReservationID = @ReservationId
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[CreateClient]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[CreateReservation]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Creates a reservation
-- =============================================
CREATE PROCEDURE [dbo].[CreateReservation]
 @ClientId int, @VehicleId int, @ReservationDateFrom datetime, @ReservationDateTo datetime
AS
	SET NOCOUNT ON;
BEGIN TRY
	BEGIN TRAN

		IF dbo.GetNumberOfActiveReservationsForClient(@ClientID) >= 3
			RAISERROR('This client has 3 active reservations. This is the maximum number of active reservations a client can have at once!', 11, 1);

		IF dbo.IsVehicleReservedForPeriod(@VehicleId, @ReservationDateFrom, @ReservationDateTo) = 1
			RAISERROR('This vehicle is already reserved for this period!', 11, 1);

		IF dbo.GetNumberOfReservationsWithSameVehicleTypeForClient(@ClientId, @VehicleId) >= 1
			RAISERROR('Two vehicles of the same type can not be reserved at the same time by the same client!', 11, 1);

		IF CAST(@ReservationDateFrom AS date) > CAST(@ReservationDateTo AS date)
			OR CAST(@ReservationDateFrom AS date) < CAST(GETDATE() AS date) OR CAST(@ReservationDateTo AS date) < CAST(GETDATE() AS date)
			RAISERROR('Date From has to be before Date To! Date From and Date To can not be before today!', 11, 1);

		IF dbo.DoesClientExist(@ClientId) = 0
			RAISERROR('Client with this ID does not exist!', 11, 1);

		IF dbo.DoesVehicleExist(@VehicleId) = 0
			RAISERROR('Vehicle with this ID does not exist!', 11, 1);

		INSERT INTO [dbo].[Reservation]
			   ([ClientID]
			   ,[VehicleID]
			   ,[ReservationDateFrom]
			   ,[ReservationDateTo]
			   ,[Active])
		 VALUES
			   (@ClientId
			   ,@VehicleId
			   ,@ReservationDateFrom
			   ,@ReservationDateTo
			   ,1)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
        ROLLBACK TRAN;

	THROW;
END CATCH

SELECT CONVERT(int, SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[CreateVehicle]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Inserts a record in Vehicle table
-- =============================================
CREATE PROCEDURE [dbo].[CreateVehicle]
@VehicleName nvarchar(200)
	, @VehicleManufacturerId int
	, @VehicleTypeId int
	, @Color nvarchar(20)
	, @DateManufactured date
	, @PricePerDay decimal(19,4)
AS
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRAN
			IF dbo.DoesManufacturerExist(@VehicleManufacturerId) = 0
				RAISERROR('Vehicle Manufacturer with this ID does not exist!', 11, 1);

			IF dbo.DoesVehicleTypeExist(@VehicleTypeId) = 0
				RAISERROR('Vehicle type with this ID does not exist!', 11, 1);

			INSERT INTO Vehicle
				(VehicleName, VehicleManufacturerID, VehicleTypeID, Color, DateManufactured, PricePerDay)
			VALUES
				(@VehicleName, @VehicleManufacturerID, @VehicleTypeID, @Color, @DateManufactured, @PricePerDay)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH

SELECT CONVERT(int, SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[CreateVehicleManufacturer]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Inserts new record in VehicleManfacturer table
-- =============================================
CREATE PROCEDURE [dbo].[CreateVehicleManufacturer]
	@VehicleManufacturerName nvarchar(200), @VehicleManufacturerDescription nvarchar(max)
AS
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO VehicleManufacturer
				(VehicleManufacturerName, VehicleManufacturerDescription)
			VALUES
				(@VehicleManufacturerName, @VehicleManufacturerDescription)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH

	SELECT CONVERT(int, SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[CreateVehicleType]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Inserts a record in Vehicle Types table
-- =============================================
CREATE PROCEDURE [dbo].[CreateVehicleType]
	@VehicleTypeName nvarchar(200), @VehicleTypeDescription nvarchar(max)
AS
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO VehicleType
				(VehicleTypeName, VehicleTypeDescription)
			VALUES
				(@VehicleTypeName, @VehicleTypeDescription)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH

	SELECT CONVERT(int, SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[DeleteClient]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Deletes a record from table Client
-- =============================================
CREATE PROCEDURE [dbo].[DeleteClient]
@ClientId int
AS
SET NOCOUNT ON

BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM Client WHERE ClientID = @ClientId) < 1
			RAISERROR('Client with this ID does not exist!', 11, 1);

		DELETE FROM Client
		WHERE ClientID = @ClientId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
        ROLLBACK TRAN;

	THROW;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[DeleteVehicle]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Deletes a record from Vehicle table based on ID
-- =============================================
CREATE PROCEDURE [dbo].[DeleteVehicle]
	@VehicleId int
AS
SET NOCOUNT ON

BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM Vehicle WHERE VehicleID = @VehicleId) < 1
			RAISERROR('Vehicle with this ID does not exist!', 11, 1);

		DELETE FROM Vehicle
		WHERE VehicleId = @VehicleId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
        ROLLBACK TRAN;

	THROW;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[DeleteVehicleManufacturer]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Deletes record from VehicleManufacturer table based on ID
-- =============================================
CREATE PROCEDURE [dbo].[DeleteVehicleManufacturer]
	@VehicleManufacturerId int
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		BEGIN TRAN
			IF(SELECT COUNT(*) FROM VehicleManufacturer WHERE VehicleManufacturerID = @VehicleManufacturerId) < 1
				RAISERROR('Vehicle Manufacturer with this ID does not exist!', 11, 1);

			DELETE FROM VehicleManufacturer
			WHERE VehicleManufacturerID = @VehicleManufacturerId
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteVehicleType]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Deletes vehicle type based on ID
-- =============================================
CREATE PROCEDURE [dbo].[DeleteVehicleType] 
	@VehicleTypeId int
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		BEGIN TRAN
			IF(SELECT COUNT(*) FROM VehicleType WHERE VehicleTypeID = @VehicleTypeId) < 1
				RAISERROR('Vehicle type with this ID does not exist!', 11, 1);

			DELETE FROM VehicleType
			WHERE VehicleTypeID = @VehicleTypeId
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRAN;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllClients]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 17.09.2022
-- Description:	Returns all records from Client table
-- =============================================
CREATE PROCEDURE [dbo].[GetAllClients]
AS
SELECT *
FROM Client
ORDER BY ClientID DESC
GO
/****** Object:  StoredProcedure [dbo].[GetAllReservations]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 17.09.2022
-- Description:	Returns all records from table Reservation
-- =============================================
CREATE PROCEDURE [dbo].[GetAllReservations]
AS
SELECT *
FROM Reservation
ORDER BY ReservationID DESC
GO
/****** Object:  StoredProcedure [dbo].[GetAllVehicleManufacturers]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns all records from VehicleManufacturer table
-- =============================================
CREATE PROCEDURE [dbo].[GetAllVehicleManufacturers]	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT *
	FROM VehicleManufacturer
	ORDER BY VehicleManufacturerID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllVehicles]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns all records from Vehicle table
-- =============================================
CREATE PROCEDURE [dbo].[GetAllVehicles] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Vehicle
	ORDER BY VehicleID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllVehicleTypes]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns all vehicle types
-- =============================================
CREATE PROCEDURE [dbo].[GetAllVehicleTypes]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM VehicleType
	ORDER BY VehicleTypeID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[GetClientById]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[GetClientsByFilters]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Returns filtered clients
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
	ORDER BY ClientID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[GetClientsForPagination]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 23.09.2022
-- Description:	Returns clients for pagination based on page number and number of records per page
-- =============================================
CREATE PROCEDURE [dbo].[GetClientsForPagination]
	@PageNumber INT = 1, @RowsPerPage INT = 10
AS
	SELECT *
	FROM Client
	ORDER BY ClientID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
GO
/****** Object:  StoredProcedure [dbo].[GetReservationById]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 18.09.2022
-- Description:	Gets reservation by id
-- =============================================
CREATE PROCEDURE [dbo].[GetReservationById]
	@ReservationId int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 *
	FROM Reservation
	WHERE ReservationID = @ReservationId
END
GO
/****** Object:  StoredProcedure [dbo].[GetReservationsForPagination]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 24.09.2022
-- Description:	Returns records from Reservation table for pagination based on page number and rows per page
-- =============================================
CREATE PROCEDURE [dbo].[GetReservationsForPagination]
	@PageNumber INT = 1, @RowsPerPage INT = 10
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM Reservation
	ORDER BY ReservationID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[GetVehicleById]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns a record from Vehicle table based on Id
-- =============================================
CREATE PROCEDURE [dbo].[GetVehicleById]
	@VehicleId int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT TOP 1 *
	FROM Vehicle
	WHERE VehicleID = @VehicleId
END
GO
/****** Object:  StoredProcedure [dbo].[GetVehicleManufacturerById]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns a records from VehicleManufacturer table based on id
-- =============================================
CREATE PROCEDURE [dbo].[GetVehicleManufacturerById]
	@VehicleManufacturerId int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT TOP 1 *
	FROM VehicleManufacturer
	WHERE VehicleManufacturerID = @VehicleManufacturerId
END
GO
/****** Object:  StoredProcedure [dbo].[GetVehiclesForPagination]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 23.09.2022
-- Description:	Returns vehicles for pagination based on number of records per page
-- =============================================
CREATE PROCEDURE [dbo].[GetVehiclesForPagination] 
	@PageNumber INT = 1, @RowsPerPage INT = 10
AS
	SELECT *
	FROM Vehicle
	ORDER BY VehicleID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
GO
/****** Object:  StoredProcedure [dbo].[GetVehicleTypeById]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Returns vehicle type by ID
-- =============================================
CREATE PROCEDURE [dbo].[GetVehicleTypeById]
	@VehicleTypeId int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT TOP 1 *
	FROM VehicleType
	WHERE VehicleTypeID = @VehicleTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[SearchReservations]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Searches for reservations by parameters
-- =============================================
CREATE PROCEDURE [dbo].[SearchReservations]
	@DateFrom datetime, @DateTo datetime, @ClientId int, @VehicleId int, @Active bit
		,@PageNumber INT = 1, @RowsPerPage INT = 10
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Reservation
	WHERE (CAST(ReservationDateFrom AS date) >= @DateFrom OR @DateFrom IS NULL)
		AND (CAST(ReservationDateTo AS date) <= @DateTo OR @DateTo IS NULL)
		AND (ClientID = @ClientId OR @ClientId IS NULL)
		AND (VehicleID = @VehicleId OR @VehicleId IS NULL)
		AND (Active = @Active OR @Active IS NULL)
	ORDER BY ReservationID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[SearchVehicles]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Searches for vehicles by parameters
-- =============================================
CREATE PROCEDURE [dbo].[SearchVehicles]
	@VehicleName nvarchar(200), @VehicleManufacturerId int, @VehicleTypeId int
	,  @PageNumber int = 1, @RowsPerPage int = 10
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM Vehicle
	WHERE (VehicleName = @VehicleName OR @VehicleName IS NULL)
		AND (VehicleManufacturerId = @VehicleManufacturerId OR @VehicleManufacturerId IS NULL)
		AND (VehicleTypeId = @VehicleTypeId OR @VehicleTypeId IS NULL)
			ORDER BY VehicleID DESC
	OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
	FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateClient]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 17.09.2022
-- Description:	Updates a record in table Client based on input parameters
-- =============================================
CREATE PROCEDURE [dbo].[UpdateClient]
@ClientId int
, @Firstname nvarchar(200)
, @Lastname nvarchar(200)
, @DriverLicenceNumber nvarchar(20)
, @PersonalIDCardNumber nvarchar(20)
, @Birthdate datetime
, @Gender char
AS

BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM Client WHERE ClientID = @ClientId) < 1
			RAISERROR('Client with this ID does not exist!', 11, 1);

		UPDATE Client SET Firstname = ISNULL(@Firstname, Firstname)
			, Lastname = ISNULL(@Lastname, Lastname)
			, Birthdate = ISNULL(@Birthdate, Birthdate)
			, Gender = ISNULL(@Gender, Gender)
			, DriverLicenceNumber = ISNULL(@DriverLicenceNumber, DriverLicenceNumber)
			, PersonalIDCardNumber = ISNULL(@PersonalIDCardNumber, PersonalIDCardNumber)
			, ModifiedDate = GETDATE()
		WHERE ClientID = @ClientId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
		ROLLBACK TRAN;
	THROW;
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[UpdateVehicle]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Updates a record in Vehicle table
-- =============================================
CREATE PROCEDURE [dbo].[UpdateVehicle]
	@VehicleId int
	, @VehicleName nvarchar(200)
	, @VehicleManufacturerId int
	, @VehicleTypeId int
	, @Color nvarchar(20)
	, @DateManufactured date
	, @PricePerDay decimal(19,4)
AS

BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM Vehicle WHERE VehicleID = @VehicleId) < 1
			RAISERROR('Vehicle with this ID does not exist!', 11, 1);

		UPDATE Vehicle SET VehicleName = ISNULL(@VehicleName, VehicleName)
			, VehicleManufacturerID = ISNULL(@VehicleManufacturerID, VehicleManufacturerID)
			, VehicleTypeId = ISNULL(@VehicleTypeId, VehicleTypeId)
			, Color = ISNULL(@Color, Color)
			, DateManufactured = ISNULL(@DateManufactured, DateManufactured)
			, PricePerDay = ISNULL(@PricePerDay, PricePerDay)
			, ModifiedDate = GETDATE()
		WHERE VehicleID = @VehicleId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
		ROLLBACK TRAN;
	THROW;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[UpdateVehicleManufacturer]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Updates VehicleManufacturer record
-- =============================================
CREATE PROCEDURE [dbo].[UpdateVehicleManufacturer]
	@VehicleManufacturerId int, @VehicleManufacturerName nvarchar(200), @VehicleManufacturerDescription nvarchar(max)
AS
BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM VehicleManufacturer WHERE VehicleManufacturerID = @VehicleManufacturerId) < 1
			RAISERROR('Vehicle Manufacturer with this ID does not exist!', 11, 1);

		UPDATE VehicleManufacturer SET VehicleManufacturerName = ISNULL(@VehicleManufacturerName, VehicleManufacturerName)
			, VehicleManufacturerDescription = ISNULL(@VehicleManufacturerDescription, VehicleManufacturerDescription)
			, ModifiedDate = GETDATE()
		WHERE VehicleManufacturerID = @VehicleManufacturerId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
		ROLLBACK TRAN;
	THROW;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[UpdateVehicleType]    Script Date: 25. 9. 2022. 14:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nino Omic
-- Create date: 19.09.2022
-- Description:	Updates Vehicle Type
-- =============================================
CREATE PROCEDURE [dbo].[UpdateVehicleType]
	@VehicleTypeId int, @VehicleTypeName nvarchar(200), @VehicleTypeDescription nvarchar(max)
AS
BEGIN TRY
	BEGIN TRAN
		IF(SELECT COUNT(*) FROM VehicleType WHERE VehicleTypeID = @VehicleTypeId) < 1
			RAISERROR('Vehicle type with this ID does not exist!', 11, 1);

		UPDATE VehicleType SET VehicleTypeName = ISNULL(@VehicleTypeName, VehicleTypeName)
			, VehicleTypeDescription = ISNULL(@VehicleTypeDescription, VehicleTypeDescription)
			, ModifiedDate = GETDATE()
		WHERE VehicleTypeID = @VehicleTypeId
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
		ROLLBACK TRAN;

	THROW;
END CATCH
GO
USE [master]
GO
ALTER DATABASE [CarRental] SET  READ_WRITE 
GO
