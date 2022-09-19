CREATE TABLE [dbo].[VehicleManufacturer] (
    [VehicleManufacturerID]          INT            IDENTITY (1, 1) NOT NULL,
    [VehicleManufacturerName]        NVARCHAR (200) NOT NULL,
    [VehicleManufacturerDescription] NVARCHAR (MAX) NULL,
    [CreatedDate]                    DATETIME       DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]                   DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([VehicleManufacturerID] ASC)
);



