USE [HookNLine]
GO

/****** Object:  StoredProcedure [WebSite].[LoginValidationGetInfo]    Script Date: 11/24/2016 6:25:14 PM ******/
DROP PROCEDURE [WebSite].[LoginValidationGetInfo]
GO

/****** Object:  StoredProcedure [WebSite].[LoginValidationGetInfo]    Script Date: 11/24/2016 6:25:14 PM ******/
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
			SELECT UserName, 
				(CASE WHEN UPPER(RTRIM(LTRIM(Password))) = UPPER(RTRIM(LTRIM(@Password))) 
				THEN 'PASS' ELSE 'FAIL' END) as Status
				FROM [WebSite].[UserNames]
				WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))
		END
	ELSE
		BEGIN
			SELECT @UserName as UserName, 'FAIL' as Status
		END	


END
GO


EXEC [WebSite].[LoginValidationGetInfo] 'TEST@qkss.com', 'Gogators'
EXEC [WebSite].[LoginValidationGetInfo] 'aeplager@qkss.com', 'STUPID'
EXEC [WebSite].[LoginValidationGetInfo] 'aeplager@qkss.com', 'Gogators'