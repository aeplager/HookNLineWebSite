USE [HookNLine]
GO

/****** Object:  StoredProcedure [WebSite].[LoginValidationGetInfo]    Script Date: 10/3/2017 4:55:30 PM ******/

/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[LoginValidationGetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[LoginValidationGetInfo]
GO


/****** Object:  StoredProcedure [WebSite].[LoginValidationGetInfo]    Script Date: 10/3/2017 4:55:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Adam Plager
-- Create date: 05/11/2015
-- Description:	Update Email Log Information
-- =============================================
CREATE PROCEDURE [WebSite].[LoginValidationGetInfo]
	-- Add the parameters for the stored procedure here		
	@UserName VARCHAR(250), @Password VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF (ISNULL((SELECT COUNT(*) FROM [WebSite].[UserNames] WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))),0) <> 0)
		BEGIN
			UPDATE [WebSite].[UserNames] SET SignedIn = 1
				,EmailSent = 1
				WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))

			SELECT UserName, (CASE WHEN [RefreshPage] = 0 THEN 'RELOAD' ELSE (CASE WHEN UPPER(RTRIM(LTRIM(Password))) = UPPER(RTRIM(LTRIM(@Password))) THEN 'PASS' ELSE @Password END) END) as Status
				FROM [WebSite].[UserNames]
				WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))
			
			UPDATE [WebSite].[UserNames] SET RefreshPage = 1
				WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))
			-- Remove previous reset password
			DELETE FROM [WebSite].[UserNameReset] WHERE UPPER(RTRIM(LTRIM([CurrentUserName]))) = UPPER(RTRIM(LTRIM(@UserName)))
		END
	ELSE
		BEGIN
			SELECT @UserName as UserName, @Password as Status
		END	


END




GO


