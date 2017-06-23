/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[LoginValidationForPurchaseGetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[LoginValidationForPurchaseGetInfo]
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
CREATE PROCEDURE [WebSite].[LoginValidationForPurchaseGetInfo]
	-- Add the parameters for the stored procedure here		
	@UserName VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @SignedIn BIT = 0
	DECLARE @EmailSentOut BIT = 0
	SELECT @SignedIn = SignedIn, @EmailSentOut = EmailSent 
		FROM [WebSite].[UserNames] 
		WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName)))

	SELECT @SignedIn as SignedIn, @EmailSentOut as EmailSentOut
END



GO
DECLARE @UserName VARCHAR(250), @ResetKey VARCHAR(250), @NewPassword VARCHAR(250)
SET @UserName = 'aeplager@qkss.com'
EXEC [WebSite].[LoginValidationForPurchaseGetInfo] @UserName
