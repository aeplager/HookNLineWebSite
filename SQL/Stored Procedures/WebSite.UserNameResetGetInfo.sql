USE [HookNLine]
GO

/****** Object:  StoredProcedure [WebSite].[UserNameResetGetInfo]    Script Date: 10/18/2017 11:19:04 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserNameResetGetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[UserNameResetGetInfo]
GO

/****** Object:  StoredProcedure [WebSite].[UserNameResetGetInfo]    Script Date: 10/18/2017 11:19:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Adam Plager
-- Create date: 05/11/2015
-- Description:	Update Email Log Information
-- =============================================
CREATE PROCEDURE [WebSite].[UserNameResetGetInfo]
	-- Add the parameters for the stored procedure here		
	@UserName as VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;			
	DECLARE @CountOfUserNames INT = (SELECT COUNT(*) FROM [WebSite].[UserNames]  WHERE UPPER(RTRIM(LTRIM(UserName))) = UPPER(RTRIM(LTRIM(@UserName))))
	SELECT @CountOfUserNames as CountOfUserNames

END


GO


EXEC [WebSite].[UserNameResetGetInfo] '12'
EXEC [WebSite].[UserNameResetGetInfo] 'aeplager@qkss.com '
EXEC [WebSite].[UserNameResetGetInfo] ' aeplager@qkss.com '