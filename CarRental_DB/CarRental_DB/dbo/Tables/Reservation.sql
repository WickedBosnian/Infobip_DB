CREATE TABLE [dbo].[Reservation] (
    [ReservationID]       INT      IDENTITY (1, 1) NOT NULL,
    [ClientID]            INT      NOT NULL,
    [ReservationDateFrom] DATETIME NOT NULL,
    [ReservationDateTo]   DATETIME NOT NULL,
    [Active]              BIT      NOT NULL,
    [CreatedDate]         DATETIME DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]        DATETIME NULL,
    PRIMARY KEY CLUSTERED ([ReservationID] ASC),
    FOREIGN KEY ([ClientID]) REFERENCES [dbo].[Client] ([ClientID])
);

