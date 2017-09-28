USE [HookNLine]
GO

/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserPurchasesUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[UserPurchasesUpsert]
GO

/****** Object:  StoredProcedure [WebSite].[UserPurchasesUpsert]    Script Date: 9/17/2017 5:16:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adam Plager
-- Create date: 05/11/2015
-- Description:	Update Email Log Information
-- =============================================
CREATE PROCEDURE [WebSite].[UserPurchasesUpsert]
	-- Add the parameters for the stored procedure here		
	@UserName VARCHAR(250), @MapSelectionID INT, @Password VARCHAR(250),  @CurrentDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		
	SET @UserName = RTRIM(LTRIM(@UserName))
	DECLARE @MapName VARCHAR(250) = (SELECT MapSelectionsShortName + ' - ' + MapSelectionsFullName FROM [WebSite].[MapSelections] WHERE [MapSelectionsID] = @MapSelectionID)
	--SELECT @MapName as MapName
	IF (ISNULL((SELECT COUNT(*) FROM [WebSite].[MapSelections] WHERE [MapSelectionsID] = @MapSelectionID),0) = 0)
		BEGIN
			-- If Map selection does not exist, return -1 which identies this as a map not configured
			SELECT -1 AS ReturnStatus, 0 as AddMap
		END 
	ELSE 
	BEGIN
		IF (ISNULL((SELECT COUNT(*) FROM [WebSite].[UserPurchases] WHERE UserName = @UserName AND MapSelectionsID = @MapSelectionID),0) = 0)
			BEGIN
				-- User Has Not Previously purchased the map				
				INSERT INTO [WebSite].[UserPurchases] (UserName, MapSelectionsID, LastPurchaseDate) 
					VALUES (@UserName, @MapSelectionID, @CurrentDate)
				IF (ISNULL((SELECT COUNT(*) FROM [WebSite].[UserNames] WHERE UserName = @UserName),0) = 0)
					BEGIN						
						SELECT 1 AS ReturnStatus, 1 as AddMap, @MapName as MapName -- User needs to be added
					END
				ELSE
					BEGIN
						SELECT 2 AS ReturnStatus, 1 as AddMap, @MapName as MapName
					END 
			END 
		ELSE 
			BEGIN
				-- Test if map exists for the date selected
				IF (ISNULL((SELECT COUNT(*) FROM [WebSite].[UserPurchases] WHERE UserName = @UserName AND MapSelectionsID = @MapSelectionID AND ISNULL(LastPurchaseDate,'1/1/1900') >= @CurrentDate),0) = 0) 
				BEGIN
					--SELECT @CurrentDate as CurrentDate , LastPurchaseDate 
					--FROM [WebSite].[UserPurchases] 
					--WHERE UserName = @UserName AND MapSelectionsID = @MapSelectionID 
					UPDATE [WebSite].[UserPurchases] SET LastPurchaseDate = @CurrentDate
						WHERE UserName = @UserName AND MapSelectionsID = @MapSelectionID 
						--AND ISNULL(LastPurchaseDate,'1/1/1900') > @CurrentDate
					SELECT 3 AS ReturnStatus, 1 as AddMap, @MapName as MapName
				END 
				ELSE
					BEGIN
						SELECT 3 as ReturnStatus, 0 as AddMap, @MapName as MapName
					END
			END 		
	END 
END


GO
DECLARE @UserName VARCHAR(250) = 'aeplager@qkss.com', @MapSelectionID INT = 1, @Password VARCHAR(250) = 'Password01', @CurrentDate DATETIME = '2017-09-17 23:03:44.487'
EXEC [WebSite].[UserPurchasesUpsert] @UserName, @MapSelectionID, @Password, @CurrentDate
