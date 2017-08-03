/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserNameValidationGetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[UserNameValidationGetInfo]
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
CREATE PROCEDURE [WebSite].[UserNameValidationGetInfo]
	-- Add the parameters for the stored procedure here
	@UserName as VARCHAR(250)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		
	IF ISNULL((SELECT COUNT(*) FROM WebSite.UserNames WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))),0) = 0
		BEGIN
			SELECT @UserName as UserName, 'N/A' as PSW, 0 as UserNameSetUp, 0 as Registered, 0 as SignedIn, 0 as LastSignInDate, CONVERT(INT,1) as RefreshPage
		END
	ELSE
		BEGIN
			SELECT UserName, Password as PSW, 1 as UserNameSetUp, ISNULL(Registered,0) as Registered, ISNULL(SignedIn,0) as SignedIn, ISNULL(LastSignInDate, CONVERT(DateTime, '1/1/1900')) as LastSignInDate, CONVERT(INT,RefreshPage) as RefreshPage
				FROM WebSite.UserNames
				WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))
				GROUP BY UserName, Password, Registered, SignedIn, LastSignInDate, RefreshPage
		END
END



GO
EXEC [WebSite].[UserNameValidationGetInfo] 'AePlager@qkss.com'