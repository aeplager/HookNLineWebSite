/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserNamePasswordUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[UserNamePasswordUpsert]
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
CREATE PROCEDURE [WebSite].[UserNamePasswordUpsert]
	-- Add the parameters for the stored procedure here
	@UserName VARCHAR(250), @Password VARCHAR(250), @FirstName VARCHAR(500), @LastName VARCHAR(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		
	DECLARE @Existing BIT = 1
	IF ISNULL((SELECT COUNT(*) FROM WebSite.UserNames WHERE UserName = @UserName),0) = 0
		BEGIN
			INSERT INTO [WebSite].[UserNames]
           ([UserName]
           ,[Password]
           ,[FirstName]
           ,[LastName]
           ,[Registered]
           ,[SignedIn]
           ,[LastSignInDate]
           )
			 VALUES
				   (@UserName
				   ,@Password
				   ,@FirstName
				   ,@LastName
				   ,0
				   ,0
				   ,GETDATE()
				   )
			SET @Existing = 0
		END
	SELECT @Existing as Existing, UserName, Password, FirstName, LastName, Registered, SignedIn, LastSignInDate
		FROM [WebSite].[UserNames]
		WHERE UserName = @UserName
END



GO
--EXEC [WebSite].[AllWayPointsGetInfo]