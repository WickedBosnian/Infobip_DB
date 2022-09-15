CREATE TABLE [dbo].[ReservedVehicle] (
    [ReservedVehicleID] INT      IDENTITY (1, 1) NOT NULL,
    [ReservationID]     INT      NOT NULL,
    [VehicleID]         INT      NOT NULL,
    [CreatedDate]       DATETIME DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ReservedVehicleID] ASC),
    FOREIGN KEY ([ReservationID]) REFERENCES [dbo].[Reservation] ([ReservationID]),
    FOREIGN KEY ([VehicleID]) REFERENCES [dbo].[Vehicle] ([VehicleID])
);

