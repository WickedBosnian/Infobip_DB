CREATE TABLE [dbo].[Reservation] (
    [ReservationID]       INT      IDENTITY (1, 1) NOT NULL,
    [ClientID]            INT      NOT NULL,
    [VehicleID]           INT      NOT NULL,
    [ReservationDateFrom] DATETIME NOT NULL,
    [ReservationDateTo]   DATETIME NOT NULL,
    [Active]              BIT      NOT NULL,
    [CreatedDate]         DATETIME DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]        DATETIME NULL,
    [CanceledDate]        DATETIME NULL,
    PRIMARY KEY CLUSTERED ([ReservationID] ASC),
    FOREIGN KEY ([ClientID]) REFERENCES [dbo].[Client] ([ClientID]),
    FOREIGN KEY ([VehicleID]) REFERENCES [dbo].[Vehicle] ([VehicleID])
);



