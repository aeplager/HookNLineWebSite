/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[InitialUserNameSetupUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[InitialUserNameSetupUpsert]
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
CREATE PROCEDURE [WebSite].[InitialUserNameSetupUpsert]
	-- Add the parameters for the stored procedure here		
	@UserName VARCHAR(250), @Password VARCHAR(250), @EmailSent BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;					
	IF (SELECT COUNT(*) FROM WebSite.UserNames 
						WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))
						) = 0
		BEGIN
			INSERT INTO WebSite.UserNames (UserName, Password, EmailSent) VALUES (RTRIM(LTRIM(@UserName)), RTRIM(LTRIM(@Password)), @EmailSent)
		END 
	ElSE
		BEGIN
			UPDATE TMP SET EmailSent = @EmailSent
				FROM WebSite.UserNames TMP
						WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))
		END

END



GO
DECLARE @UserName VARCHAR(250), @ResetKey VARCHAR(250), @NewPassword VARCHAR(250) = 'SHIT', @SHIT BIT = 1
SET @UserName = 'aeplager@qkss.com'
DELETE FROM WebSite.UserNames WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))
--EXEC [WebSite].[InitialUserNameSetupUpsert] @UserName, @NewPassword, @SHIT 
SELECT * FROM WebSite.UserNames
