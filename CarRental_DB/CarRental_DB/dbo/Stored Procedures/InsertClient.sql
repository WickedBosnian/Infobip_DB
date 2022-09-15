-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE InsertClient 
	-- Add the parameters for the stored procedure here
	@Firstname nvarchar(200)
AS
BEGIN

	INSERT INTO [dbo].[Client]
           ([Firstname]
           ,[Lastname]
		   ,[Birthdate]
           ,[DriverLicenceNumber]
		   )
     VALUES
           (@Firstname
		   ,'test'
		   ,'2000-01-01'
		   ,'TESTT'
		   )

END