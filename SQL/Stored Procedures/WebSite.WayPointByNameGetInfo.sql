/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WayPointByNameGetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[WayPointByNameGetInfo]
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
CREATE PROCEDURE [WebSite].[WayPointByNameGetInfo]
	-- Add the parameters for the stored procedure here	
	@WayPointName VARCHAR(500)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		
	SELECT [WayPointsID], [WayPointName], [Latitude], [Longitude], [FishingText], [BestWindText], [TypeOfFishingText]
		FROM WebSite.WayPoints
		WHERE WayPointName = @WayPointName 
		GROUP BY [WayPointsID], [WayPointName], [Latitude], [Longitude], [FishingText], [BestWindText], [TypeOfFishingText]
		ORDER BY [WayPointName]
END



GO
EXEC [WebSite].[WayPointByNameGetInfo] '�C� REEF'