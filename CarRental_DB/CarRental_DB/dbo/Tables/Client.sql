CREATE TABLE [dbo].[Client] (
    [ClientID]             INT            IDENTITY (1, 1) NOT NULL,
    [Firstname]            NVARCHAR (200) NOT NULL,
    [Lastname]             NVARCHAR (200) NOT NULL,
    [Birthdate]            DATE           NULL,
    [Gender]               CHAR (1)       NULL,
    [DriverLicenceNumber]  NVARCHAR (20)  NOT NULL,
    [PersonalIDCardNumber] NVARCHAR (20)  NULL,
    [CreatedDate]          DATETIME       DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]         DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([ClientID] ASC),
    UNIQUE NONCLUSTERED ([DriverLicenceNumber] ASC)
);






GO
CREATE NONCLUSTERED INDEX [IX_Lastname]
    ON [dbo].[Client]([Lastname] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Firstname]
    ON [dbo].[Client]([Firstname] ASC);

