-- =============================================================================================
-- Create Stored Procedure Template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =============================================================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--DROP PROCEDURE WebSite.SpecificWayPointGetInfo
CREATE PROCEDURE WebSite.SpecificWayPointGetInfo
	-- Add the parameters for the stored procedure here
	@Lat as FLOAT, @Lng as Float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SET @Lat = ROUND(@Lat,10)
	SET @Lng = ROUND(@Lng,10)
    -- Insert statements for procedure here
	SELECT	TOP 1 [WayPointsID], [WayPointName], [Latitude], [Longitude], [FishingText], [BestWindText], [TypeOfFishingText]
	,WT.[WayPointTypeID],[WayPointTypeName]
	,geography::STGeomFromText('POINT(' + CONVERT(VARCHAR(250),@Lng) + ' ' + CONVERT(VARCHAR(250),@Lat) + ')', 4326).STDistance([GeoLocation])  as Distance
	FROM	[WebSite].[WayPoints] W
	INNER JOIN WebSite.WayPointType WT ON W.[WayPointTypeID] = WT.[WayPointTypeID]
	ORDER BY geography::STGeomFromText('POINT(' + CONVERT(VARCHAR(250),@Lng) + ' ' + CONVERT(VARCHAR(250),@Lat) + ')', 4326).STDistance([GeoLocation]) 
END
GO
EXEC WebSite.SpecificWayPointGetInfo 29.029155948781362,-95.20992279052734

EXEC WebSite.SpecificWayPointGetInfo 30.729155948781362,-95.80992279052734


--29.029155948781362