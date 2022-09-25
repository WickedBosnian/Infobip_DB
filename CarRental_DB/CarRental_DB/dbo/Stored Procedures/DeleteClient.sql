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