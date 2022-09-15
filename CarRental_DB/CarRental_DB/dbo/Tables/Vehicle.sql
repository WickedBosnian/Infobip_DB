CREATE TABLE [dbo].[Vehicle] (
    [VehicleID]             INT             IDENTITY (1, 1) NOT NULL,
    [VehicleManufacturerID] INT             NOT NULL,
    [VehicleTypeID]         INT             NOT NULL,
    [Color]                 NVARCHAR (20)   NULL,
    [DateManufactured]      DATE            NOT NULL,
    [PricePerDay]           DECIMAL (19, 4) NOT NULL,
    [CreatedDate]           DATETIME        DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]          DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([VehicleID] ASC),
    FOREIGN KEY ([VehicleManufacturerID]) REFERENCES [dbo].[VehicleManufacturer] ([VehicleManufacturerID]),
    FOREIGN KEY ([VehicleTypeID]) REFERENCES [dbo].[VehicleType] ([VehicleTypeID])
);

