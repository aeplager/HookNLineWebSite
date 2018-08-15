USE [HookNLine]
GO

/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserPurchasesGetInfoAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[UserPurchasesGetInfoAll]
GO

/****** Object:  StoredProcedure [WebSite].[UserPurchasesGetInfoAll]    Script Date: 9/17/2017 5:16:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adam Plager
-- Create date: 05/11/2015
-- Description:	Update Email Log Information
-- =============================================
CREATE PROCEDURE [WebSite].[UserPurchasesGetInfoAll]
	-- Add the parameters for the stored procedure here		
	@UserName VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		
	SET @UserName = UPPER(RTRIM(LTRIM(@UserName)))
	DECLARE @Table TABLE (MapName VARCHAR(250))
	INSERT INTO @Table (MapName)
	SELECT 
      [MapSelectionsShortName] + '-' + [MapSelectionsFullName] as MapName      
  FROM [WebSite].[MapSelections]
  WHERE [MapSelectionsID] = 2

  INSERT INTO @Table (MapName)
	SELECT M.[MapSelectionsShortName] + '-' + M.[MapSelectionsFullName] as MapName
	FROM [WebSite].[UserNames] U
	INNER JOIN [WebSite].[UserPurchases] P ON U.UserName = P.UserName
	INNER JOIN [WebSite].[MapSelections] M ON P.[MapSelectionsID] = M.[MapSelectionsID]
	WHERE UPPER(RTRIM(LTRIM(U.UserName))) = @UserName

	SELECT MapName FROM @Table
END


GO
DECLARE @UserName VARCHAR(250) = 'aeplager@qkss.com'
EXEC [WebSite].[UserPurchasesGetInfoAll] @UserName
