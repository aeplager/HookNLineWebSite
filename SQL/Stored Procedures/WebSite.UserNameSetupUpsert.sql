/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserNameSetupUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[UserNameSetupUpsert]
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
CREATE PROCEDURE [WebSite].[UserNameSetupUpsert]
	-- Add the parameters for the stored procedure here		
	@UserName VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;				
	DECLARE @RandChar VARCHAR(5) = (SELECT (CONVERT(INT,RAND()*100000)) as RandomChar)
	DECLARE @PSW AS VARCHAR(250) = (SELECT [Password] FROM [WebSite].[UserNames] WHERE RTRIM(LTRIM([UserName])) = @UserName)
	DECLARE @CurrentDate DATETIME = GETDATE()
	UPDATE [WebSite].[UserNameReset] SET [Reset] = 1 WHERE [CurrentUserName] = @UserName 
	INSERT INTO [WebSite].[UserNameReset]
			   (
			   [CurrentUserName]
			   ,[CurrentPassword] 
			   ,[NewPassword]          
			   ,[Reset]
			   ,[ResetStartDate]
			   ,[ResetKey]
			   ,[InsertDate]
			   ,[LastModifiedDate]
			   )
		 VALUES
				(
				@UserName 
			   ,@PSW 
			   ,@PSW
			   ,1
			   ,@CurrentDate 
			   ,@RandChar
			   ,@CurrentDate 
			   ,@CurrentDate 
				)
	SELECT @RandChar as RandChar
END



GO
DECLARE @UserName VARCHAR(250), @ResetKey VARCHAR(250), @NewPassword VARCHAR(250)
SET @UserName = 'cedrictech1@gmail.com '
EXEC [WebSite].[UserNameSetupUpsert] @UserName
