/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserNameResetUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[UserNameResetUpsert]
GO


/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Adam Plager
-- Create date: 05/11/2015
-- Description:	Update Email Log Information
-- =============================================
CREATE PROCEDURE [WebSite].[UserNameResetUpsert]
	-- Add the parameters for the stored procedure here		
	@ResetKey VARCHAR(250),@NewPassword VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;			
	IF ((SELECT COUNT(*) FROM WebSite.UserNameReset WHERE ResetKey = @ResetKey) > 0)
		BEGIN									
			DECLARE @MaxUserNameResetID INT, @UserName VARCHAR(250)
			SET @MaxUserNameResetID = ISNULL((SELECT Max([UserNameResetID]) as MaxUserNameResetID FROM [WebSite].[UserNameReset] 
				WHERE RTRIM(LTRIM([ResetKey])) = RTRIM(LTRIM(@ResetKey))),0)
			SET @UserName = (SELECT [CurrentUserName] FROM [WebSite].[UserNameReset] WHERE ResetKey = @ResetKey)
			UPDATE [WebSite].[UserNameReset] SET [Reset] = 1, ResetEndDate = GETDATE(), LastModifiedDate = GETDATE()
				WHERE RTRIM(LTRIM([ResetKey])) = RTRIM(LTRIM(@ResetKey))			
			UPDATE [WebSite].[UserNames] SET Password = @NewPassword
				WHERE RTRIM(LTRIM(UserName)) = @UserName			
			SELECT 'PASS' as Status
		END 
	ELSE
		BEGIN
			SELECT 'FAIL' as Status
		END 
END



GO
DECLARE @UserName VARCHAR(250), @ResetKey VARCHAR(250), @NewPassword VARCHAR(250)
SET @UserName = 'aeplager@qkss.com'
SET @ResetKey  = 'RESETNOW'
SET @NewPassword = '123'

EXEC [WebSite].[UserNameResetUpsert] @ResetKey, @NewPassword

SELECT * FROM [WebSite].[UserNames]
SELECT *  FROM [WebSite].[UserNameReset]