CREATE TABLE [dbo].[VehicleType] (
    [VehicleTypeID]          INT            IDENTITY (1, 1) NOT NULL,
    [VehicleTypeName]        NVARCHAR (200) NOT NULL,
    [VehicleTypeDescription] NVARCHAR (MAX) NULL,
    [CreatedDate]            DATETIME       DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]           DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([VehicleTypeID] ASC)
);



